CREATE TABLE `about` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `body` text NOT NULL,
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `engine_schema_info` (
  `engine_name` varchar(255) default NULL,
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL auto_increment,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL default '0',
  `job_id` int(11) NOT NULL default '0',
  `student_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `user_id` int(11) NOT NULL default '0',
  `start_date` date NOT NULL default '0000-00-00',
  `end_date` date NOT NULL default '0000-00-00',
  `title` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `qualifications` text NOT NULL,
  `how_to_apply` text NOT NULL,
  `street_address` varchar(255) NOT NULL default '',
  `city` varchar(255) NOT NULL default '',
  `state` tinytext NOT NULL,
  `zip` int(11) NOT NULL default '0',
  `pay_min` int(11) NOT NULL default '0',
  `pay_max` int(11) NOT NULL default '0',
  `pay_increment` varchar(255) NOT NULL default '',
  `time_required` varchar(255) NOT NULL default '',
  `flexible` tinyint(4) NOT NULL default '0',
  `private` tinyint(4) NOT NULL default '0',
  `deactivated` tinyint(4) NOT NULL default '0',
  `babysitter` tinyint(4) NOT NULL default '0',
  `car_required` tinyint(4) NOT NULL default '0',
  `references_required` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `notes` (
  `id` int(11) NOT NULL auto_increment,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL default '0',
  `job_id` int(11) NOT NULL default '0',
  `student_id` int(11) NOT NULL default '0',
  `body` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `reports` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `user_id` int(11) NOT NULL default '0',
  `job_id` int(11) NOT NULL default '0',
  `student_id` int(11) NOT NULL default '0',
  `reason` text NOT NULL,
  `resolved` tinyint(4) NOT NULL default '0',
  `post_type` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `students` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `user_id` int(11) NOT NULL default '0',
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `title` varchar(255) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  `looking_for` varchar(255) NOT NULL default '',
  `has_car` int(11) NOT NULL default '0',
  `has_references` int(11) NOT NULL default '0',
  `resume` varchar(255) NOT NULL default '',
  `private` tinyint(255) NOT NULL default '0',
  `deactivated` tinyint(4) NOT NULL default '0',
  `babysitter` tinyint(4) NOT NULL default '0',
  `street_address` varchar(255) NOT NULL default '',
  `city` varchar(255) NOT NULL default '',
  `state` tinytext NOT NULL,
  `zip` int(11) NOT NULL default '0',
  `time_requested` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `taggings` (
  `id` int(11) NOT NULL auto_increment,
  `tag_id` int(11) default NULL,
  `taggable_id` int(11) default NULL,
  `taggable_type` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tips` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `body` text NOT NULL,
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `identity` int(11) NOT NULL default '0',
  `login` varchar(80) NOT NULL default '',
  `salted_password` varchar(40) NOT NULL default '',
  `email` varchar(60) NOT NULL default '',
  `firstname` varchar(40) default NULL,
  `lastname` varchar(40) default NULL,
  `company_name` varchar(255) NOT NULL default '',
  `salt` varchar(40) NOT NULL default '',
  `verified` int(11) default '0',
  `role` varchar(40) default NULL,
  `security_token` varchar(40) default NULL,
  `token_expiry` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `logged_in_at` datetime default NULL,
  `deleted` int(11) default '0',
  `delete_after` datetime default NULL,
  `address1` varchar(255) NOT NULL default '',
  `address2` varchar(255) NOT NULL default '',
  `city` varchar(255) NOT NULL default '',
  `state` tinytext NOT NULL,
  `zip_code` int(11) NOT NULL default '0',
  `email_address` varchar(255) NOT NULL default '',
  `telephone` varchar(255) NOT NULL default '',
  `heard_how` varchar(255) NOT NULL default '',
  `job_interested_in` varchar(255) NOT NULL default '',
  `receive_emails` tinyint(4) NOT NULL default '0',
  `sg_notifications` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `welcomes` (
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO schema_info (version) VALUES (2)