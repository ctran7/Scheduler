require "Time"
class HomeController < ApplicationController

  def index
    @times = WorkOrder.select("time").order("time ASC")
    @techs = Technician.select("name")
    @work_orders = WorkOrder.includes(:location).includes(:technician).all
    beginning = @times[0].time[0,2].to_i
    ending = @times[-1].time[0,2].to_i
    @hours = (beginning..ending).to_a.map { |num| num.to_s + ":00" }
    size = @times[-1].time[0,2].to_i - @times[0].time[0,2].to_i + 1


    @br = ["0","123"]

    @tech_1 = Array.new(size) { Array.new() }
    @tech_2 = Array.new(size) { Array.new() }
    @tech_3 = Array.new(size) { Array.new() }
    @tech_4 = Array.new(size) { Array.new() }
    @work_orders.each do |t|
        puts t.class
        i = t.time[0,2].to_i - beginning
        tech_id = t.technician_id
        case tech_id
        when 1
            @tech_1[i].push(t.location.name, t.location.city, t.time, "$" + t.price.to_s)
        when 2
            @tech_2[i].push(t.location.name, t.location.city, t.time, "$" + t.price.to_s)
        when 3
            @tech_3[i].push(t.location.name, t.location.city, t.time, "$" + t.price.to_s)
        when 4
            @tech_4[i].push(t.location.name, t.location.city, t.time, "$" + t.price.to_s)
        else
          puts "Error: invalid technician id"
        end
    end

    calculate_difference_for_blanks(@tech_1)
    calculate_difference_for_blanks(@tech_2)
    calculate_difference_for_blanks(@tech_3)
    calculate_difference_for_blanks(@tech_4)

    end


    def calculate_difference_for_blanks(current_tech)
      prev_wo = nil
      next_wo = nil
      len = current_tech.length()
      current_tech.each_with_index do |t, i|
        #if entry at that time is empty find the next avaliable time
        if current_tech[i].empty?

          #if there is no previous order find the first one
          if !prev_wo
            current_tech[i] = [time_diff_no_prev(i, current_tech, len)]
          elsif !next_wo
            current_tech[i] = [time_diff_no_next(i, current_tech, len, prev_wo)]
          end

        else
          prev_wo =current_tech[i][2].to_time
          next_wo = nil
        end
      end
    end

    def time_diff_no_prev(i, current_tech, len)
      n = i
        if n < len-1
          #puts n.to_s + " " + len.to_s
            while current_tech[n].empty?
              if n == len-1
                puts "no more orders for the day"
                return "N/A"
              end
              n +=1
            end
          diff = Time.at(current_tech[n][2].to_time - @times[0].time.to_time).utc.strftime("%H:%M:%S")
          puts "empty at " + i.to_s + " but difference between the next order: " + diff.to_s
          return diff.to_s
        else
          puts "no more orders for the day"
          return "N/A"
        end
    end

    def time_diff_no_next(i, current_tech, len, prev_wo)
      n = i
      if n < len-1
          while current_tech[n].empty?
            if n == len-1
              puts "NEED TO FIX"
              diff = Time.at(@times[-1].time.to_time - prev_wo).utc.strftime("%H:%M:%S")
              puts "empty at " + i.to_s + " but difference between the next order: " + diff.to_s
              return diff.to_s
            end
            n +=1
          end
        diff = Time.at(current_tech[n][2].to_time - prev_wo).utc.strftime("%H:%M:%S")
        puts "empty at " + i.to_s + " but difference between the next order: " + diff.to_s
        return diff.to_s
      else
        puts "NEED TO FIX"
        diff = Time.at(@times[-1].time.to_time - prev_wo).utc.strftime("%H:%M:%S")
        puts "empty at " + i.to_s + " but difference between the next order: " + diff.to_s
        return diff.to_s
      end

    end



  end
