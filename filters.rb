# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program


  def find(id, candidates)
    # Using find with a block to search for matching id
    candidates.find { |candidate| candidate[:id] == id }
  end

  def experienced?(candidate)
    # Your code Here
    years_of_experience = candidate["years_of_experience"]
 return years_of_experience >= 2
  end
  
  # More methods will go below

  # Helper method to check recent application
def recent_application?(candidate)
  # Assuming "applied_at" is a date key in the candidate hash
  applied_at = candidate["applied_at"]
  return applied_at && applied_at > 15.days.ago
end

# Helper method to check programming language skills
def knows_ruby_or_python?(candidate)
  languages = candidate["programming_languages"] || []
  languages.include?("Ruby") || languages.include?("Python")
end

def qualified_candidates(candidates)
  candidates.select do |candidate|
    experienced?(candidate) &&
      candidate["github_points"] >= 100 &&
      knows_ruby_or_python?(candidate) &&
      recent_application?(candidate) &&
      candidate["age"] >= 18
  end
end

def ordered_by_qualifications(candidates)
  candidates.sort do |candidate1, candidate2|
    # Sort by experience (descending)
    experience_diff = candidate2["years_of_experience"] <=> candidate1["years_of_experience"]
    # If experience is the same, sort by Github points (descending)
    return experience_diff unless experience_diff.zero?
    candidate2["github_points"] <=> candidate1["github_points"]
  end
end