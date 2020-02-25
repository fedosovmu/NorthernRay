SET DATESTYLE TO 'iso, dmy';

CREATE SEQUENCE public.user_id_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE public."user"
(
  user_id smallint NOT NULL DEFAULT nextval('public.user_id_seq'::regclass),
  user_name character varying NOT NULL,
  user_domain character varying NOT NULL,
  user_full_name character varying NOT NULL,
  person boolean NOT NULL,
  enabled boolean NOT NULL,
  CONSTRAINT pk_user_id PRIMARY KEY (user_id),
  CONSTRAINT un_user_user_name_user_domain UNIQUE (user_name, user_domain)
);

CREATE SEQUENCE public.workflow_type_id_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE public.workflow_type
(
  workflow_type_id smallint NOT NULL DEFAULT nextval('public.workflow_type_id_seq'::regclass),
  "name" character varying NOT NULL,
  title character varying NOT NULL,
  path character varying NOT NULL,
  icon_path character varying NOT NULL,
  "order" smallint NOT NULL,
  enabled boolean NOT NULL,
  CONSTRAINT pk_workflow_type_id PRIMARY KEY (workflow_type_id),
  CONSTRAINT un_workflow_name UNIQUE (name),
  CONSTRAINT un_workflow_path UNIQUE (path),
  CONSTRAINT un_workflow_title UNIQUE (title)
);

CREATE SEQUENCE public.file_id_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE public.file
(
  file_id bigint NOT NULL DEFAULT nextval('public.file_id_seq'::regclass),
  name character varying NOT NULL,
  path character varying NOT NULL,
  date timestamp without time zone NOT NULL,
  guid character varying NOT NULL,
  CONSTRAINT pk_file_id PRIMARY KEY (file_id)
);

INSERT INTO public."user"
(
user_id,
user_name,
user_domain,
user_full_name,
person,
enabled
)
VALUES
(
0,
'$workflow_engine$',
'WS06',
'Служба Workflow Engine',
False,
True
);

INSERT INTO public."user"
(
user_name,
user_domain,
user_full_name,
person,
enabled
)
VALUES
(
'user',
'WS06',
'Михаил',
True,
True
);

create schema messenger
	authorization postgres;

create sequence messenger.ad_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.color_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.color_scheme_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.date_format_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.font_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.group_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.message_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.password_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.priority_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.reply_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.texts_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.tip_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create sequence messenger.user_id_sequence
	increment	1
	minvalue	0
	maxvalue	9223372036854775807
	start		1
	cache		1;

create table messenger.ad
(
	ad_id			smallint		not null	default nextval('messenger.ad_id_sequence'),
	title			character varying	not null,
	text			character varying	not null,
	link_program		character varying,
	link_argument		character varying,
	constraint pk_ad_id				primary key (ad_id),
	constraint un_ad_title			 	unique (title)
)
	with OIDs;

create table messenger.color
(
	color_id		smallint		not null	default nextval('messenger.color_id_sequence'),
	title			character varying	not null,
	alpha			smallint		not null,
	red			smallint		not null,
	green			smallint		not null,
	blue			smallint		not null,
	constraint pk_color_id				primary key (color_id),
	constraint un_color_title		 	unique (title)
)
	with OIDs;

create table messenger.color_scheme
(
	color_scheme_id		smallint		not null	default nextval('messenger.color_scheme_id_sequence'),
	title			character varying	not null,
	back_head_color_id	smallint		not null,
	font_head_color_id	smallint		not null,
	back_body_color_id	smallint		not null,
	font_body_color_id	smallint		not null,
	delimiter_color_id	smallint		not null,
	constraint pk_color_scheme_id			primary key (color_scheme_id),
	constraint un_color_scheme_title	 	unique (title)
)
	with OIDs;

create table messenger.date_format
(
	date_format_id		smallint		not null	default nextval('messenger.date_format_id_sequence'),
	title			character varying	not null,
	value			character varying	not null,
	constraint pk_date_format_id			primary key (date_format_id),
	constraint un_date_format_title		 	unique (title)
)
	with OIDs;

create table messenger.font
(
	font_id			smallint		not null	default nextval('messenger.font_id_sequence'),
	title			character varying	not null,
	value			character varying	not null,
	size			double precision	not null,
	constraint pk_font_id				primary key (font_id),
	constraint un_font_title		 	unique (title)
)
	with OIDs;

create table messenger.group
(
	group_id		smallint		not null	default nextval('messenger.group_id_sequence'),
	title			character varying	not null,
	priority		double precision	not null,
	color_scheme_id		smallint		not null,
	font_id			smallint		not null,
	date_format_id		smallint		not null,
	texts_id		smallint		not null,
	tip_id			smallint		not null,
	constraint pk_group_id				primary key (group_id),
	constraint un_group_title		 	unique (title)
)
	with OIDs;

create table messenger.message
(
	message_id		bigint				not null	default nextval('messenger.message_id_sequence'),
	version_id		integer				not null,
	auto_generated		boolean				not null,
	date_created		timestamp(0) without time zone	not null,
	date_changed		timestamp(0) without time zone	not null,
	author_id		smallint			not null,
	priority_id		smallint			not null,
	theme			character varying		not null,
	short			character varying		not null,
	text			character varying		not null,
	dead_line		timestamp(0) without time zone	not null,
	link_title		character varying		not null,
	link_program		character varying		not null,
	link_argument		character varying		not null,
	start_condition_date	timestamp(0) without time zone	not null,
	finish_condition_count	smallint			not null,
	finish_condition_date	timestamp(0) without time zone	not null,
	brake_condition_count	smallint			not null,
	period			double precision		not null,
	start_hour		double precision		not null,
	finish_hour		double precision		not null,
	missed_show_period	double precision		not null,
	mandatory_look		boolean				not null,
	mandatory_text		boolean				not null,
	mandatory_url		boolean				not null,
	mandatory_answer	boolean				not null,
	notify_author		boolean				not null,
	forbid_answer		boolean				not null,
	ttl_after_done		double precision		not null,
	notify_author_done	boolean				not null,
	notify_author_delete	boolean				not null,
	done			boolean				not null,
	date_done		timestamp(0) without time zone	not null,
	constraint pk_message_id						primary key (message_id),
	constraint ch_message_missed_show_period_is_less_or_equal_than_period	check (missed_show_period <= period)
)
	with OIDs;

create table messenger.password
(
	password_id		smallint		not null	default nextval('messenger.password_id_sequence'),
	title			character varying	not null,
	password_hash		character varying	not null,
	constraint pk_password_id			primary key (password_id),
	constraint un_password_title		 	unique (title)
)
	with OIDs;

create table messenger.priority
(
	priority_id		smallint		not null	default nextval('messenger.priority_id_sequence'),
	title			character varying	not null, 
	value			double precision	not null,
	constraint pk_priority_id			primary key (priority_id),
	constraint un_priority_title		 	unique (title)
)
	with OIDs;

create table messenger.reply
(
	reply_id			bigint				not null	default nextval('messenger.reply_id_sequence'),
	version_id			integer				not null,
	message_id			bigint				not null,
	addressee_id			smallint			not null,
	accept_look			boolean				not null,
	accept_text			boolean				not null,
	accept_url			boolean				not null,
	accept_answer			boolean				not null,
	answer				character varying		not null,
	reverse_notify_author		boolean				not null,
	reverse_mandatory_answer	boolean 			not null,
	reverse_forbid_answer		boolean				not null,
	date_changed			timestamp(0) without time zone	not null,
	date_prev			timestamp(0) without time zone	not null,
	remind_count			smallint			not null,
	paused				boolean				not null,
	date_paused			timestamp(0) without time zone	not null,
	stopped				boolean				not null,
	date_stopped			timestamp(0) without time zone	not null,
	broken				boolean				not null,
	date_broken			timestamp(0) without time zone	not null,
	finished			boolean				not null,
	date_finished			timestamp(0) without time zone	not null,
	constraint pk_reply_id						primary key (reply_id),
	constraint un_reply_message_id_addressee_id 			unique (message_id, addressee_id)
)
	with OIDs;

create table messenger.texts
(
	texts_id		smallint		not null	default nextval('messenger.texts_id_sequence'),
	title			character varying	not null,
	text1			character varying	not null,
	text24			character varying	not null,
	text50			character varying	not null,
	common_text24		character varying	not null,
	common_text50		character varying	not null,
	constraint pk_texts_id				primary key (texts_id),
	constraint un_texts_title		 	unique (title)
)
	with OIDs;

create table messenger.tip
(
	tip_id			smallint		not null	default nextval('messenger.tip_id_sequence'),
	title			character varying	not null,
	value			character varying	not null,
	constraint pk_tip_id				primary key (tip_id),
	constraint un_tip_title		 		unique (title)
)
	with OIDs;

create table messenger.user
(
	user_id			smallint		not null	default nextval('messenger.user_id_sequence'),
	public_user_id		smallint		not null,
	allowed_priority	double precision	not null,
	group_id		smallint		not null,
	constraint pk_user_id				primary key (user_id),
	constraint un_user_public_user_id	 	unique (public_user_id)
)
	with OIDs;

alter table messenger.color_scheme
	add constraint fk_color_scheme_back_body_color_id foreign key (back_body_color_id)
		references messenger.color
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.color_scheme
	add constraint fk_color_scheme_back_head_color_id foreign key (back_head_color_id)
		references messenger.color
		match full
		on delete no action
		on update no action
		not deferrable;


alter table messenger.color_scheme
	add constraint fk_color_scheme_font_body_color_id foreign key (font_body_color_id)
		references messenger.color
		match full
		on delete no action
		on update no action
		not deferrable;


alter table messenger.color_scheme
	add constraint fk_color_scheme_font_head_color_id foreign key (font_head_color_id)
		references messenger.color
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.color_scheme
	add constraint fk_color_scheme_delimiter_color_id foreign key (delimiter_color_id)
		references messenger.color
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.group
	add constraint fK_group_color_scheme_id foreign key (color_scheme_id)
		references messenger.color_scheme
		match full
		on delete no action
		on update no action
		not deferrable;


alter table messenger.group
	add constraint fk_group_date_format_id foreign key (date_format_id)
		references messenger.date_format
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.group
	add constraint fk_group_font_id foreign key (font_id)
		references messenger.font
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.group
	add constraint fk_group_texts_id foreign key (texts_id)
		references messenger.texts
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.group
	add constraint fk_group_tip_id foreign key (tip_id)
		references messenger.tip
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.message
	add constraint fk_message_priority_id foreign key (priority_id)
		references messenger.priority
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.message
	add constraint fk_message_author_id foreign key (author_id)
		references messenger.user
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.reply
	add constraint fk_reply_message_id foreign key (message_id)
		references messenger.message
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.reply
	add constraint fk_reply_addressee_id foreign key (addressee_id)
		references messenger.user
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.user
	add constraint fk_user_group_id foreign key (group_id)
		references messenger.group
		match full
		on delete no action
		on update no action
		not deferrable;

alter table messenger.user
	add constraint fk_user_public_user_id foreign key (public_user_id)
		references public.user (user_id)
		match full
		on delete no action
		on update no action
		not deferrable;

create type messenger.ad_type as
(
	ad_id			smallint,
	title			character varying,
	text			character varying,
	link_program		character varying,
	link_argument		character varying
);

create type messenger.color_type as
(
	color_id		smallint,
	title			character varying,
	alpha			smallint,
	red			smallint,
	green			smallint,
	blue			smallint
);

create type messenger.color_scheme_type as
(
	color_scheme_id		smallint,
	title			character varying,
	back_head_color_id	smallint,
	font_head_color_id	smallint,
	back_body_color_id	smallint,
	font_body_color_id	smallint,
	delimiter_color_id	smallint
);

create type messenger.date_format_type as
(
	date_format_id		smallint,
	title			character varying,
	value			character varying
);

create type messenger.font_type as
(
	font_id			smallint,
	title			character varying,
	value			character varying,
	size			double precision
);

create type messenger.group_type as
(
	group_id		smallint,
	title			character varying,
	priority		double precision,
	color_scheme_id		smallint,
	font_id			smallint,
	date_format_id		smallint,
	texts_id		smallint,
	tip_id			smallint
);

create type messenger.message_type as
(
	message_id		bigint,
	version_id		integer,
	auto_generated		boolean,
	date_created		timestamp(0) without time zone,
	date_changed		timestamp(0) without time zone,
	author_id		smallint,
	priority_id		smallint,
	theme			character varying,
	short			character varying,
	text			character varying,
	dead_line		timestamp(0) without time zone,
	link_title		character varying,
	link_program		character varying,
	link_argument		character varying,
	start_condition_date	timestamp(0) without time zone,
	finish_condition_count	smallint,
	finish_condition_date	timestamp(0) without time zone,
	brake_condition_count	smallint,
	period			double precision,
	start_hour		double precision,
	finish_hour		double precision,
	missed_show_period	double precision,
	mandatory_look		boolean,
	mandatory_text		boolean,
	mandatory_url		boolean,
	mandatory_answer	boolean,
	notify_author		boolean,
	forbid_answer		boolean,
	ttl_after_done		double precision,
	notify_author_done	boolean,
	notify_author_delete	boolean,
	done			boolean,
	date_done		timestamp(0) without time zone
);

create type messenger.password_type as
(
	password_id		smallint,
	title			character varying,
	password_hash		character varying
);

create type messenger.priority_type as
(
	priority_id		smallint,
	title			character varying,
	value			double precision
);

create type messenger.reply_type as
(
	reply_id			bigint,
	version_id			integer,
	message_id			bigint,
	addressee_id			smallint,
	accept_look			boolean,
	accept_text			boolean,
	accept_url			boolean,
	accept_answer			boolean,
	answer				character varying,
	reverse_notify_author		boolean,
	reverse_mandatory_answer	boolean,
	reverse_forbid_answer		boolean,
	date_changed			timestamp(0) without time zone,
	date_prev			timestamp(0) without time zone,
	remind_count			smallint,
	paused				boolean,
	date_paused			timestamp(0) without time zone,
	stopped				boolean,
	date_stopped			timestamp(0) without time zone,
	broken				boolean,
	date_broken			timestamp(0) without time zone,
	finished			boolean,
	date_finished			timestamp(0) without time zone
);

create type messenger.texts_type as
(
	texts_id		smallint,
	title			character varying,
	text1			character varying,
	text24			character varying,
	text50			character varying,
	common_text24		character varying,
	common_text50		character varying
);

create type messenger.tip_type as
(
	tip_id			smallint,
	title			character varying,
	value			character varying
);

create type messenger.user_type as
(
	user_id			smallint,
	user_name		character varying,
	user_domain		character varying,
	user_full_name		character varying,
	person			boolean,
	allowed_priority	double precision,
	group_id		smallint,
	enabled			boolean
);

create or replace function messenger.add_message_with_getting_id
(
	boolean,
	timestamp(0) without time zone,
	timestamp(0) without time zone,
	smallint,
	smallint,
	character varying,
	character varying,
	character varying,
	timestamp(0) without time zone,
	character varying,
	character varying,
	character varying,
	timestamp(0) without time zone,
	smallint,
	timestamp(0) without time zone,
	smallint,
	double precision,
	double precision,
	double precision,
	double precision,
	boolean,
	boolean,
	boolean,
	boolean,
	boolean,
	boolean,
	double precision,
	boolean,
	boolean,
	boolean,
	timestamp(0) without time zone
)
	returns bigint as
	$body$
		insert into
			messenger.message
			values
			(
				default,
				1,
				$1,
				$2,
				$3,
				$4,
				$5,
				$6,
				$7,
				$8,
				$9,
				$10,
				$11,
				$12,
				$13,
				$14,
				$15,
				$16,
				$17,
				$18,
				$19,
				$20,
				$21,
				$22,
				$23,
				$24,
				$25,
				$26,
				$27,
				$28,
				$29,
				$30,
				$31
			)
			returning message_id;
	$body$
	language 'sql';

create or replace function messenger.add_reply_with_getting_id
(
	bigint,
	smallint,
	boolean,
	boolean,
	boolean,
	boolean,
	character varying,
	boolean,
	boolean,
	boolean,
	timestamp(0) without time zone,
	timestamp(0) without time zone,
	smallint,
	boolean,
	timestamp(0) without time zone,
	boolean,
	timestamp(0) without time zone,
	boolean,
	timestamp(0) without time zone,
	boolean,
	timestamp(0) without time zone
)
	returns bigint as
	$body$
		insert into
			messenger.reply
			values
			(
				default,
				1,
				$1,
				$2,
				$3,
				$4,
				$5,
				$6,
				$7,
				$8,
				$9,
				$10,
				$11,
				$12,
				$13,
				$14,
				$15,
				$16,
				$17,
				$18,
				$19,
				$20,
				$21
			)
			returning reply_id;
	$body$
	language 'sql';

create or replace function messenger.delete_message
(
	bigint
)
	returns void as
	$body$
		delete from
			messenger.message
			where
				message_id = $1
	$body$
	language 'sql';

create or replace function messenger.delete_message
(
	timestamp(0) without time zone
)
	returns void as
	$body$
		delete from
			messenger.reply
			where
				message_id in
				(
					select
						message_id
						from
							messenger.message
						where
							message_id in
							(
								select
									message_id
									from
										messenger.message
									where
										done = True
							) and
							date_done + cast(cast(ttl_after_done * 3600 as text) || ' seconds' as interval) <= $1
				);

		delete from
			messenger.message
			where
				message_id in
				(
					select
						message_id
						from
							messenger.message
						where
							message_id in
							(
								select
									message_id
									from
										messenger.message
									where
										done = True
							) and
							date_done + cast(cast(ttl_after_done * 3600 as text) || ' seconds' as interval) <= $1
				)
	$body$
	language 'sql';

create or replace function messenger.delete_reply
(
	bigint
)
	returns void as
	$body$
		delete from
			messenger.reply
			where
				reply_id = $1
	$body$
	language 'sql';

create or replace function messenger.get_ads()
	returns setof messenger.ad_type as
	$body$
		select
			ad_id,
			title,
			text,
			link_program,
			link_argument
			from
				messenger.ad
	$body$
	language 'sql';

create or replace function messenger.get_colors()
	returns setof messenger.color_type as
	$body$
		select
			color_id,
			title,
			alpha,
			red,
			green,
			blue
			from
				messenger.color
	$body$
	language 'sql';

create or replace function messenger.get_color_schemes()
	returns setof messenger.color_scheme_type as
	$body$
		select
			color_scheme_id,
			title,
			back_head_color_id,
			font_head_color_id,
			back_body_color_id,
			font_body_color_id,
			delimiter_color_id
			from
				messenger.color_scheme
	$body$
	language 'sql';

create or replace function messenger.get_date_formats()
	returns setof messenger.date_format_type as
	$body$
		select
			date_format_id,
			title,
			value
			from
				messenger.date_format
	$body$
	language 'sql';

create or replace function messenger.get_fonts()
	returns setof messenger.font_type as
	$body$
		select
			font_id,
			title,
			value,
			size
			from
				messenger.font
	$body$
	language 'sql';

create or replace function messenger.get_groups()
	returns setof messenger.group_type as
	$body$
		select
			group_id,
			title,
			priority,
			color_scheme_id,
			font_id,
			date_format_id,
			texts_id,
			tip_id
			from
				messenger.group
	$body$
	language 'sql';

create or replace function messenger.get_messages_by_addressee_user_name_and_addressee_user_domain
(
	character varying,
	character varying
)
	returns setof messenger.message_type as
	$body$
		select
			message_id,
			version_id,
			auto_generated,
			date_created,
			date_changed,
			author_id,
			priority_id,
			theme,
			short,
			text,
			dead_line,
			link_title,
			link_program,
			link_argument,
			start_condition_date,
			finish_condition_count,
			finish_condition_date,
			brake_condition_count,
			period,
			start_hour,
			finish_hour,
			missed_show_period,
			mandatory_look,
			mandatory_text,
			mandatory_url,
			mandatory_answer,
			notify_author,
			forbid_answer,
			ttl_after_done,
			notify_author_done,
			notify_author_delete,
			done,
			date_done
			from
				messenger.message
			where
				message_id in
				(
					select
						message_id
						from
							messenger.reply
						where
							addressee_id in
							(
								select
									user_id
									from
										messenger.user
									where
										public_user_id in
										(	
											select
												user_id
												from
													public.user
												where
													(user_name = $1) and
													(user_domain = $2)
										)
							)
				)
	$body$
	language 'sql';

create or replace function messenger.get_messages_by_author_user_name_and_author_user_domain
(
	character varying,
	character varying
)
	returns setof messenger.message_type as
	$body$
		select
			message_id,
			version_id,
			auto_generated,
			date_created,
			date_changed,
			author_id,
			priority_id,
			theme,
			short,
			text,
			dead_line,
			link_title,
			link_program,
			link_argument,
			start_condition_date,
			finish_condition_count,
			finish_condition_date,
			brake_condition_count,
			period,
			start_hour,
			finish_hour,
			missed_show_period,
			mandatory_look,
			mandatory_text,
			mandatory_url,
			mandatory_answer,
			notify_author,
			forbid_answer,
			ttl_after_done,
			notify_author_done,
			notify_author_delete,
			done,
			date_done
			from
				messenger.message
			where
				author_id in
				(
					select
						user_id
						from
							messenger.user
						where
							public_user_id in
							(	
								select
									user_id
									from
										public.user
									where
										(user_name = $1) and
										(user_domain = $2)
							)
				) and
				(auto_generated = False)
	$body$
	language 'sql';

create or replace function messenger.get_old_messages
(
	timestamp(0) without time zone
)
	returns setof messenger.message_type as
	$body$
		select
			message_id,
			version_id,
			auto_generated,
			date_created,
			date_changed,
			author_id,
			priority_id,
			theme,
			short,
			text,
			dead_line,
			link_title,
			link_program,
			link_argument,
			start_condition_date,
			finish_condition_count,
			finish_condition_date,
			brake_condition_count,
			period,
			start_hour,
			finish_hour,
			missed_show_period,
			mandatory_look,
			mandatory_text,
			mandatory_url,
			mandatory_answer,
			notify_author,
			forbid_answer,
			ttl_after_done,
			notify_author_done,
			notify_author_delete,
			done,
			date_done
			from
				messenger.message
			where
				message_id in
				(
					select
						message_id
						from
							messenger.message
						where
							done = True
				) and
				date_done + cast(cast(ttl_after_done * 3600 as text) || ' seconds' as interval) <= $1
	$body$
	language 'sql';

create or replace function messenger.get_passwords()
	returns setof messenger.password_type as
	$body$
		select
			password_id,
			title,
			password_hash
			from
				messenger.password
	$body$
	language 'sql';

create or replace function messenger.get_priorities()
	returns setof messenger.priority_type as
	$body$
		select
			priority_id,
			title,
			value
			from
				messenger.priority
	$body$
	language 'sql';

create or replace function messenger.get_replies_for_addressee_user_name_and_addressee_user_domain
(
	character varying,
	character varying
)
	returns setof messenger.reply_type as
	$body$
		select
			reply_id,
			version_id,
			message_id,
			addressee_id,
			accept_look,
			accept_text,
			accept_url,
			accept_answer,
			answer,
			reverse_notify_author,
			reverse_mandatory_answer,
			reverse_forbid_answer,
			date_changed,
			date_prev,
			remind_count,
			paused,
			date_paused,
			stopped,
			date_stopped,
			broken,
			date_broken,
			finished,
			date_finished
			from
				messenger.reply
			where
				message_id in
				(
					select
						message_id
						from
							messenger.message
						where
							message_id in
						(
							select
								message_id
								from
									messenger.reply
								where
									addressee_id in
								(
									select
										user_id
										from
											messenger.user
										where
											public_user_id in
											(	
												select
													user_id
													from
														public.user
													where
														(user_name = $1) and
														(user_domain = $2)
											)
								)
						)
				)
	$body$
	language 'sql';

create or replace function messenger.get_replies_by_addressee_user_name_and_addressee_user_domain
(
	character varying,
	character varying
)
	returns setof messenger.reply_type as
	$body$
		select
			reply_id,
			version_id,
			message_id,
			addressee_id,
			accept_look,
			accept_text,
			accept_url,
			accept_answer,
			answer,
			reverse_notify_author,
			reverse_mandatory_answer,
			reverse_forbid_answer,
			date_changed,
			date_prev,
			remind_count,
			paused,
			date_paused,
			stopped,
			date_stopped,
			broken,
			date_broken,
			finished,
			date_finished
			from
				messenger.reply
			where
				addressee_id in
				(
					select
						user_id
						from
							messenger.user
						where
							public_user_id in
							(	
								select
									user_id
									from
										public.user
									where
										(user_name = $1) and
										(user_domain = $2)
							)
				)
	$body$
	language 'sql';

create or replace function messenger.get_replies_by_author_user_name_and_author_user_domain
(
	character varying,
	character varying
)
	returns setof messenger.reply_type as
	$body$
		select
			reply_id,
			version_id,
			message_id,
			addressee_id,
			accept_look,
			accept_text,
			accept_url,
			accept_answer,
			answer,
			reverse_notify_author,
			reverse_mandatory_answer,
			reverse_forbid_answer,
			date_changed,
			date_prev,
			remind_count,
			paused,
			date_paused,
			stopped,
			date_stopped,
			broken,
			date_broken,
			finished,
			date_finished
			from
				messenger.reply
			where
				message_id in
				(
					select
						message_id
						from
							messenger.message
						where
							author_id in
						(
							select
								user_id
								from
									messenger.user
								where
									public_user_id in
									(	
										select
											user_id
											from
												public.user
											where
												(user_name = $1) and
												(user_domain = $2)
									)
						) and
						(auto_generated = False)
				)
	$body$
	language 'sql';

create or replace function messenger.get_replies_of_old_messages
(
	timestamp(0) without time zone
)
	returns setof messenger.reply_type as
	$body$
		select
			reply_id,
			version_id,
			message_id,
			addressee_id,
			accept_look,
			accept_text,
			accept_url,
			accept_answer,
			answer,
			reverse_notify_author,
			reverse_mandatory_answer,
			reverse_forbid_answer,
			date_changed,
			date_prev,
			remind_count,
			paused,
			date_paused,
			stopped,
			date_stopped,
			broken,
			date_broken,
			finished,
			date_finished
			from
				messenger.reply
			where
				message_id in
				(
					select
						message_id
						from
							messenger.message
						where
							message_id in
							(
								select
									message_id
									from
										messenger.message
									where
										done = True
							) and
							date_done + cast(cast(ttl_after_done * 3600 as text) || ' seconds' as interval) <= $1
				)
	$body$
	language 'sql';

create or replace function messenger.get_texts()
	returns setof messenger.texts_type as
	$body$
		select
			texts_id,
			title,
			text1,
			text24,
			text50,
			common_text24,
			common_text50
			from
				messenger.texts
	$body$
	language 'sql';

create or replace function messenger.get_tips()
	returns setof messenger.tip_type as
	$body$
		select
			tip_id,
			title,
			value
			from
				messenger.tip
	$body$
	language 'sql';

create or replace function messenger.get_users()
	returns setof messenger.user_type as
	$body$
		select
			messenger.user.user_id,
			public.user.user_name,
			public.user.user_domain,
			public.user.user_full_name,
			public.user.person,
			allowed_priority,
			group_id,
			public.user.enabled
			from
				messenger.user, public.user
			where
				messenger.user.public_user_id = public.user.user_id
	$body$
	language 'sql';

create or replace function messenger.update_message
(
	bigint,
	boolean,
	timestamp(0) without time zone,
	timestamp(0) without time zone,
	smallint,
	smallint,
	character varying,
	character varying,
	character varying,
	timestamp(0) without time zone,
	character varying,
	character varying,
	character varying,
	timestamp(0) without time zone,
	smallint,
	timestamp(0) without time zone,
	smallint,
	double precision,
	double precision,
	double precision,
	double precision,
	boolean,
	boolean,
	boolean,
	boolean,
	boolean,
	boolean,
	double precision,
	boolean,
	boolean,
	boolean,
	timestamp(0) without time zone
)
	returns void as
	$body$
		update messenger.message
			set
				version_id = version_id + 1,
				auto_generated = $2,
				date_created = $3,
				date_changed = $4,
				author_id = $5,
				priority_id = $6,
				theme = $7,
				short = $8,
				text = $9,
				dead_line = $10,
				link_title = $11,
				link_program = $12,
				link_argument = $13,
				start_condition_date = $14,
				finish_condition_count = $15,
				finish_condition_date = $16,
				brake_condition_count = $17,
				period = $18,
				start_hour = $19,
				finish_hour = $20,
				missed_show_period = $21,
				mandatory_look = $22,
				mandatory_text = $23,
				mandatory_url = $24,
				mandatory_answer = $25,
				notify_author = $26,
				forbid_answer = $27,
				ttl_after_done = $28,
				notify_author_done = $29,
				notify_author_delete = $30,
				done = $31,
				date_done = $32
			where
				message_id = $1;
	$body$
	language 'sql';

create or replace function messenger.update_reply
(
	bigint,
	bigint,
	smallint,
	boolean,
	boolean,
	boolean,
	boolean,
	character varying,
	boolean,
	boolean,
	boolean,
	timestamp(0) without time zone,
	timestamp(0) without time zone,
	smallint,
	boolean,
	timestamp(0) without time zone,
	boolean,
	timestamp(0) without time zone,
	boolean,
	timestamp(0) without time zone,
	boolean,
	timestamp(0) without time zone
)
	returns void as
	$body$
		update messenger.reply
			set
				version_id = version_id + 1,
				message_id = $2,
				addressee_id = $3,
				accept_look = $4,
				accept_text = $5,
				accept_url = $6,
				accept_answer = $7,
				answer = $8,
				reverse_notify_author = $9,
				reverse_mandatory_answer = $10,
				reverse_forbid_answer = $11,
				date_changed = $12,
				date_prev = $13,
				remind_count = $14,
				paused = $15,
				date_paused = $16,
				stopped = $17,
				date_stopped = $18,
				broken = $19,
				date_broken = $20,
				finished = $21,
				date_finished = $22
			where
				reply_id = $1;
	$body$
	language 'sql';

insert into
	messenger.color
	(
		title,
		alpha,
		red,
		green,
		blue
	)
	values
	(
		'ColorBlack',
		255,
		0,
		0,
		0
	);

insert into
	messenger.color
	(
		title,
		alpha,
		red,
		green,
		blue
	)
	values
	(
		'ColorWhite254',
		255,
		254,
		254,
		254
	);

insert into messenger.color_scheme
(
	title,
	back_head_color_id,
	font_head_color_id,
	back_body_color_id,
	font_body_color_id,
	delimiter_color_id
)
	select
		'ColorSchemeSystemAccount',
		messenger_color_back_head_color.color_id,
		messenger_color_font_head_color.color_id,
		messenger_color_back_body_color.color_id,
		messenger_color_font_body_color.color_id,
		messenger_color_delimiter_color.color_id
		from
			(select 1) as fiction_table
		left outer join
			messenger.color as messenger_color_back_head_color
		on
			messenger_color_back_head_color.title = 'ColorBlack'
		left outer join
			messenger.color as messenger_color_font_head_color
		on
			messenger_color_font_head_color.title = 'ColorWhite254'
		left outer join
			messenger.color as messenger_color_back_body_color
		on
			messenger_color_back_body_color.title = 'ColorBlack'
		left outer join
			messenger.color as messenger_color_font_body_color
		on
			messenger_color_font_body_color.title = 'ColorWhite254'
		left outer join
			messenger.color as messenger_color_delimiter_color
		on
			messenger_color_delimiter_color.title = 'ColorWhite254';

insert into
	messenger.date_format
	(
		title,
		value
	)
	values
	(
		'DateFormatSystemAccount',
		'HH:mm'
	);

insert into
	messenger.font
	(
		title,
		value,
		size
	)
	values
	(
		'FontSystemAccount',
		'<Default Font>',
		15
	);

insert into
	messenger.texts
	(
		title,
		text1,
		text24,
		text50,
		common_text24,
		common_text50
	)
	values
	(
		'TextsSystemAccount',
		'СООБЩЕНИЕ',
		'СООБЩЕНИЯ',
		'СООБЩЕНИЙ',
		'СООБЩЕНИЯ',
		'СООБЩЕНИЙ'
	);

insert into
	messenger.tip
	(
		title,
		value
	)
	values
	(
		'TipSystemAccount',
		' '
	);

insert into
	messenger.group
	(
		title,
		priority,
		color_scheme_id,
		font_id,
		date_format_id,
		texts_id,
		tip_id
	)
	select
		'GroupSystemAccount',
		0,
		messenger_color_scheme.color_scheme_id,
		messenger_font.font_id,
		messenger_date_format.date_format_id,
		messenger_texts.texts_id,
		messenger_tip.tip_id
		from
			(select 1) as fiction_table
		left outer join
			messenger.color_scheme as messenger_color_scheme
		on
			messenger_color_scheme.title = 'ColorSchemeSystemAccount'
		left outer join
			messenger.font as messenger_font
		on
			messenger_font.title = 'FontSystemAccount'
		left outer join
			messenger.date_format as messenger_date_format
		on
			messenger_date_format.title = 'DateFormatSystemAccount'
		left outer join
			messenger.texts as messenger_texts
		on
			messenger_texts.title = 'TextsSystemAccount'
		left outer join
			messenger.tip as messenger_tip
		on
			messenger_tip.title = 'TipSystemAccount';

insert into
	messenger.password
	(
		title,
		password_hash
	)
	values
	(
		'Пароль администратора сообщений',
		'iвЄPЏ›я9Q®Ц…дЙ'
	);

insert into
	messenger.priority
	(
		title,
		value
	)
	values
	(
		'Администраторский',
		1
	);

insert into
	messenger.priority
	(
		title,
		value
	)
	values
	(
		'Высокий',
		2
	);

insert into
	messenger.priority
	(
		title,
		value
	)
	values
	(
		'Обычный',
		3
	);

INSERT INTO messenger."user"
(
public_user_id,
allowed_priority,
group_id
)
SELECT
user_id,
2,
1
FROM
public."user"
WHERE
(user_name = 'user') AND
(user_domain = 'WS06');

insert into
	public.user
	(
		user_name,
		user_domain,
		user_full_name,
		enabled,
		person
	)
	values
	(
		'$messenger$',
		'WS06',
		'Служба Messenger',
		True,
		False
	);


insert into
	messenger.user
	(
		public_user_id,
		allowed_priority,
		group_id
	)
	select
		public_user.user_id,
		0.0,
		messenger_group.group_id
		from
			(select 1) as fiction_table
		left outer join
			public.user as public_user
		on
			(public_user.user_name = '$messenger$') and
			(public_user.user_domain = 'WS06') and
			(public_user.user_full_name = 'Служба Messenger')
		left outer join
			messenger.group as messenger_group
		on
			messenger_group.title = 'GroupSystemAccount';



INSERT INTO public.workflow_type
(
  "name",
  title,
  path,
  "order",
  icon_path,
  enabled
)
VALUES
(
  'Wash',
  'Автомойка',
  E'D:\\WorkflowTechnology\\Clients\\MChel\\Projects\\1. Wash\\Workflow\\Wash.xml',
  (
  SELECT
    COUNT(*) + 1
  FROM
    public.workflow_type
  ),
  E'..\\..\\1. Wash\\Forms\\Images\\Icon.png',
  True
);

create schema wash
	authorization postgres;

CREATE SEQUENCE wash.action_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.executed_step_status_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.executive_group_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.executive_user_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
  
CREATE SEQUENCE wash.form_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.form_group_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.group_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.group_group_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.message_appearance_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.reply_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.step_state_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.step_state_workflow_state_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.step_status_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.step_type_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.update_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.user_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.user_group_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.workflow_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE wash.workflow_state_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE wash."action"
(
  action_id smallint NOT NULL DEFAULT nextval('wash.action_id_seq'::regclass),
  "name" character varying NOT NULL,
  title character varying NOT NULL,
  CONSTRAINT pk_action_id PRIMARY KEY (action_id),
  CONSTRAINT un_action_name UNIQUE (name),
  CONSTRAINT un_action_title UNIQUE (title)
);

CREATE TABLE wash.executed_step_status
(
  executed_step_status_id smallint NOT NULL DEFAULT nextval('wash.executed_step_status_id_seq'::regclass),
  "name" character varying NOT NULL,
  title character varying NOT NULL,
  CONSTRAINT pk_executed_step_status_id PRIMARY KEY (executed_step_status_id),
  CONSTRAINT un_executed_step_status_name UNIQUE (name),
  CONSTRAINT un_executed_step_status_title UNIQUE (title)
);

CREATE TABLE wash.executive_group
(
  executive_group_id bigint NOT NULL DEFAULT nextval('wash.executive_group_id_seq'::regclass),
  step_type_id smallint NOT NULL,
  workflow_id bigint NOT NULL,
  group_id smallint NOT NULL,
  CONSTRAINT pk_executive_group_id PRIMARY KEY (executive_group_id),
  CONSTRAINT un_executive_group_all UNIQUE (step_type_id, workflow_id, group_id)
);

CREATE TABLE wash.executive_user
(
  executive_user_id bigint NOT NULL DEFAULT nextval('wash.executive_user_id_seq'::regclass),
  step_type_id smallint NOT NULL,
  workflow_id bigint NOT NULL,
  user_id smallint NOT NULL,
  CONSTRAINT pk_executive_user_id PRIMARY KEY (executive_user_id),
  CONSTRAINT un_executive_user_all UNIQUE (step_type_id, workflow_id, user_id)
);

CREATE TABLE wash.form
(
  form_id smallint NOT NULL DEFAULT nextval('wash.form_id_seq'::regclass),
  "name" character varying NOT NULL,
  title character varying NOT NULL,
  path character varying NOT NULL,
  description character varying,
  workflow_type_id smallint NOT NULL,
  "order" smallint NOT NULL,
  enabled boolean,
  CONSTRAINT pk_form_id PRIMARY KEY (form_id),
  CONSTRAINT un_form_name UNIQUE (name),
  CONSTRAINT un_form_order UNIQUE ("order"),
  CONSTRAINT un_form_path UNIQUE (path),
  CONSTRAINT un_form_title UNIQUE (title)
);

CREATE TABLE wash.form_group
(
  form_group_id smallint NOT NULL DEFAULT nextval('wash.form_group_id_seq'::regclass),
  form_id smallint NOT NULL,
  group_id smallint NOT NULL,
  CONSTRAINT pk_form_group_id PRIMARY KEY (form_group_id),
  CONSTRAINT un_form_group_all UNIQUE (form_id, group_id)
);

CREATE TABLE wash."group"
(
  group_id smallint NOT NULL DEFAULT nextval('wash.group_id_seq'::regclass),
  "name" character varying NOT NULL,
  title character varying NOT NULL,
  description character varying,
  CONSTRAINT pk_group_id PRIMARY KEY (group_id),
  CONSTRAINT un_group_name UNIQUE (name)
);

CREATE TABLE wash.group_group
(
  group_group_id smallint NOT NULL DEFAULT nextval('wash.group_group_id_seq'::regclass),
  child_group_id smallint NOT NULL,
  parent_group_id smallint NOT NULL,
  CONSTRAINT pk_group_group_id PRIMARY KEY (group_group_id),
  CONSTRAINT un_group_group_child_group_id_parent_group_id UNIQUE (child_group_id, parent_group_id),
  CONSTRAINT ch_group_group_child_group_id_is_not_parent_group_id CHECK (child_group_id <> parent_group_id)
);

CREATE TABLE wash.message_appearance
(
  message_appearance_id smallint NOT NULL DEFAULT nextval('wash.message_appearance_id_seq'::regclass),
  step_type_id smallint NOT NULL,
  enabled boolean NOT NULL,
  messenger_user_id smallint NOT NULL,
  messenger_priority_id smallint NOT NULL,
  theme character varying NOT NULL,
  short character varying NOT NULL,
  "text" character varying,
  dead_line timestamp without time zone,
  dead_line_shift interval,
  link_title character varying,
  link_program character varying,
  link_argument character varying,
  start_condition_date timestamp without time zone,
  start_condition_date_shift interval,
  finish_condition_count smallint NOT NULL,
  finish_condition_date timestamp without time zone,
  finish_condition_date_shift interval,
  brake_condition_count smallint NOT NULL,
  period double precision,
  period_variable character varying,
  start_hour double precision NOT NULL,
  finish_hour double precision NOT NULL,
  missed_show_period double precision,
  missed_show_period_variable character varying,
  mandatory_look boolean NOT NULL,
  mandatory_text boolean NOT NULL,
  mandatory_url boolean NOT NULL,
  CONSTRAINT pk_message_appearance_id PRIMARY KEY (message_appearance_id)
);

CREATE TABLE wash.reply
(
  reply_id bigint NOT NULL DEFAULT nextval('wash.reply_id_seq'::regclass),
  step_type_id smallint NOT NULL,
  workflow_id bigint NOT NULL,
  user_id smallint NOT NULL,
  messenger_reply_id bigint,
  paused boolean,
  CONSTRAINT pk_reply_id PRIMARY KEY (reply_id),
  CONSTRAINT un_reply_messenger_reply_id UNIQUE (messenger_reply_id)
);

CREATE TABLE wash.step_state
(
  step_state_id bigint NOT NULL DEFAULT nextval('wash.step_state_id_seq'::regclass),
  step_type_id smallint NOT NULL,
  step_status_id smallint NOT NULL,
  executed_step_status_id smallint,
  editor_id smallint NOT NULL,
  CONSTRAINT pk_step_state_id PRIMARY KEY (step_state_id)
);

CREATE TABLE wash.step_state_workflow_state
(
  step_state_workflow_state_id bigint NOT NULL DEFAULT nextval('wash.step_state_workflow_state_id_seq'::regclass),
  workflow_state_id bigint NOT NULL,
  step_state_id bigint NOT NULL,
  CONSTRAINT pk_step_state_workflow_state_id PRIMARY KEY (step_state_workflow_state_id),
  CONSTRAINT un_step_state_workflow_state_all UNIQUE (workflow_state_id, step_state_id)
);

CREATE TABLE wash.step_status
(
  step_status_id smallint NOT NULL DEFAULT nextval('wash.step_status_id_seq'::regclass),
  "name" character varying NOT NULL,
  title character varying NOT NULL,
  CONSTRAINT pk_step_status_id PRIMARY KEY (step_status_id),
  CONSTRAINT un_step_status_name UNIQUE (name),
  CONSTRAINT un_step_status_title UNIQUE (title)
);

CREATE TABLE wash.step_type
(
  step_type_id smallint NOT NULL DEFAULT nextval('wash.step_type_id_seq'::regclass),
  "name" character varying NOT NULL,
  title character varying NOT NULL,
  short character varying NOT NULL,
  "order" smallint NOT NULL,
  CONSTRAINT pk_step_type_id PRIMARY KEY (step_type_id),
  CONSTRAINT un_step_name UNIQUE (name),
  CONSTRAINT un_step_title UNIQUE (title)
);

CREATE TABLE wash."update"
(
  update_id bigint NOT NULL DEFAULT nextval('wash.update_id_seq'::regclass),
  query_name character varying NOT NULL,
  table_name character varying NOT NULL,
  "type" character varying NOT NULL,
  parameter character varying NOT NULL,
  user_id smallint,
  date timestamp without time zone NOT NULL,
  CONSTRAINT pk_update_id PRIMARY KEY (update_id)
);

CREATE TABLE wash."user"
(
  user_id smallint NOT NULL DEFAULT nextval('wash.user_id_seq'::regclass),
  public_user_id smallint NOT NULL,
  CONSTRAINT pk_user_id PRIMARY KEY (user_id),
  CONSTRAINT un_user_public_user_id UNIQUE (public_user_id)
);

CREATE TABLE wash.user_group
(
  user_group_id smallint NOT NULL DEFAULT nextval('wash.user_group_id_seq'::regclass),
  user_id smallint NOT NULL,
  group_id smallint NOT NULL,
  CONSTRAINT pk_user_group_id PRIMARY KEY (user_group_id),
  CONSTRAINT un_user_group_user_id_group_id UNIQUE (user_id, group_id)
);

CREATE TABLE wash.workflow
(
  workflow_id bigint NOT NULL DEFAULT nextval('wash.workflow_id_seq'::regclass),
  title character varying NOT NULL,
  workflow_state_id bigint,
  CONSTRAINT pk_workflow_id PRIMARY KEY (workflow_id),
  CONSTRAINT un_workflow_title UNIQUE (title),
  CONSTRAINT un_workflow_workflow_state_id UNIQUE (workflow_state_id)
);

CREATE TABLE wash.workflow_state
(
  workflow_state_id bigint NOT NULL DEFAULT nextval('wash.workflow_state_id_seq'::regclass),
  workflow_id bigint NOT NULL,
  action_id bigint NOT NULL,
  initiator_id smallint NOT NULL,
  allow_rollback boolean NOT NULL,
  date timestamp without time zone NOT NULL,
  CONSTRAINT pk_workflow_state_id PRIMARY KEY (workflow_state_id)
);

ALTER TABLE wash.executive_group
  ADD CONSTRAINT fk_executive_group_group_id FOREIGN KEY (group_id)
      REFERENCES wash."group" (group_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
ALTER TABLE wash.executive_group
  ADD CONSTRAINT fk_executive_group_step_type_id FOREIGN KEY (step_type_id)
      REFERENCES wash.step_type (step_type_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
ALTER TABLE wash.executive_group
  ADD CONSTRAINT fk_executive_group_workflow_id FOREIGN KEY (workflow_id)
      REFERENCES wash.workflow (workflow_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;
      
ALTER TABLE wash.executive_user
  ADD CONSTRAINT fk_executive_user_user_id FOREIGN KEY (user_id)
      REFERENCES wash.user (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
ALTER TABLE wash.executive_user
  ADD CONSTRAINT fk_executive_user_step_type_id FOREIGN KEY (step_type_id)
      REFERENCES wash.step_type (step_type_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
ALTER TABLE wash.executive_user
  ADD CONSTRAINT fk_executive_user_workflow_id FOREIGN KEY (workflow_id)
      REFERENCES wash.workflow (workflow_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;
      
ALTER TABLE wash.form
  ADD CONSTRAINT fk_form_workflow_type_id FOREIGN KEY (workflow_type_id)
      REFERENCES public.workflow_type (workflow_type_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.form_group
  ADD CONSTRAINT fk_form_group_form_id FOREIGN KEY (form_id)
      REFERENCES wash.form (form_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.form_group
  ADD CONSTRAINT fk_form_group_group_id FOREIGN KEY (group_id)
      REFERENCES wash."group" (group_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
ALTER TABLE wash.group_group
  ADD CONSTRAINT fk_group_group_child_group_id FOREIGN KEY (child_group_id)
      REFERENCES wash."group" (group_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;
      
ALTER TABLE wash.group_group
  ADD CONSTRAINT fk_group_group_parent_group_id FOREIGN KEY (parent_group_id)
      REFERENCES wash."group" (group_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;
      
ALTER TABLE wash.message_appearance
  ADD CONSTRAINT fk_message_appearance_messenger_priority_id FOREIGN KEY (messenger_priority_id)
      REFERENCES messenger.priority (priority_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.message_appearance
  ADD CONSTRAINT fk_message_appearance_messenger_user_id FOREIGN KEY (messenger_user_id)
      REFERENCES messenger."user" (user_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
ALTER TABLE wash.message_appearance
  ADD CONSTRAINT fk_message_appearance_step_type_id FOREIGN KEY (step_type_id)
      REFERENCES wash.step_type (step_type_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.reply
  ADD CONSTRAINT fk_reply_messenger_reply_id FOREIGN KEY (messenger_reply_id)
      REFERENCES messenger.reply (reply_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE wash.reply
  ADD CONSTRAINT fk_reply_step_type_id FOREIGN KEY (step_type_id)
      REFERENCES wash.step_type (step_type_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.reply
  ADD CONSTRAINT fk_reply_user_id FOREIGN KEY (user_id)
      REFERENCES wash."user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.reply
  ADD CONSTRAINT fk_reply_workflow_id FOREIGN KEY (workflow_id)
      REFERENCES wash.workflow (workflow_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;
      
ALTER TABLE wash.step_state
  ADD CONSTRAINT fk_step_state_editor_id FOREIGN KEY (editor_id)
      REFERENCES wash."user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.step_state
  ADD CONSTRAINT fk_step_state_executed_step_status_id FOREIGN KEY (executed_step_status_id)
      REFERENCES wash.executed_step_status (executed_step_status_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.step_state
  ADD CONSTRAINT fk_step_state_step_status_id FOREIGN KEY (step_status_id)
      REFERENCES wash.step_status (step_status_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.step_state
  ADD CONSTRAINT fk_step_state_step_type_id FOREIGN KEY (step_type_id)
      REFERENCES wash.step_type (step_type_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.step_state_workflow_state
  ADD CONSTRAINT fk_step_state_id FOREIGN KEY (step_state_id)
      REFERENCES wash.step_state (step_state_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.step_state_workflow_state
  ADD CONSTRAINT fk_workflow_state_id FOREIGN KEY (workflow_state_id)
      REFERENCES wash.workflow_state (workflow_state_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash."update"
  ADD CONSTRAINT fk_update_user_id FOREIGN KEY (user_id)
      REFERENCES wash."user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash."user"
  ADD CONSTRAINT fk_user_public_user_id FOREIGN KEY (public_user_id)
      REFERENCES public."user" (user_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.user_group
  ADD CONSTRAINT fk_user_group_group_id FOREIGN KEY (group_id)
      REFERENCES wash."group" (group_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE wash.user_group
  ADD CONSTRAINT fk_user_group_user_id FOREIGN KEY (user_id)
      REFERENCES wash."user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE wash.workflow
  ADD CONSTRAINT fk_workflow_workflow_state_id FOREIGN KEY (workflow_state_id)
      REFERENCES wash.workflow_state (workflow_state_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.workflow_state
  ADD CONSTRAINT fk_workflow_state_action_id FOREIGN KEY (action_id)
      REFERENCES wash."action" (action_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.workflow_state
  ADD CONSTRAINT fk_workflow_state_initiator_id FOREIGN KEY (initiator_id)
      REFERENCES wash."user" (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE wash.workflow_state
  ADD CONSTRAINT fk_workflow_state_workflow_id FOREIGN KEY (workflow_id)
      REFERENCES wash.workflow (workflow_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

INSERT INTO wash."action"
(
"name",
title
)
VALUES
(
'Initiate',
'Инициация'
);

INSERT INTO wash."action"
(
"name",
title
)
VALUES
(
'Execute',
'Выполнение'
);

INSERT INTO wash."action"
(
"name",
title
)
VALUES
(
'Stop',
'Остановка'
);

INSERT INTO wash."action"
(
"name",
title
)
VALUES
(
'Resume',
'Возобновление'
);

INSERT INTO wash."action"
(
"name",
title
)
VALUES
(
'Rollback',
'Откат'
);

INSERT INTO wash."group"
(
"name",
title,
description
)
VALUES
(
'MainGroup',
'<Все группы>',
'Все группы'
);

INSERT INTO wash.step_status
(
"name",
title
)
VALUES
(
'Started',
'Активен'
);

INSERT INTO wash.step_status
(
"name",
title
)
VALUES
(
'Broken',
'Прерван'
);

INSERT INTO wash.step_status
(
"name",
title
)
VALUES
(
'Executed',
'Завершен'
);

INSERT INTO wash.step_status
(
"name",
title
)
VALUES
(
'Stopped',
'Остановлен'
);

INSERT INTO wash."user"
(
user_id,
public_user_id
)
VALUES
(
0,
0
);

INSERT INTO wash."group"
(
"name",
title,
description
)
VALUES
(
'AdministratorGroup',
'Администраторы',
'Администраторы процесса, полный доступ'
);

INSERT INTO wash."group"
(
"name",
title,
description
)
VALUES
(
'OwnerGroup',
'Владельцы',
'Владельцы процесса, полный доступ (кроме системных таблиц)'
);

INSERT INTO wash."group"
(
"name",
title,
description
)
VALUES
(
'ReaderGroup',
'Читающие',
'Читающие, доступ только для чтения'
);

INSERT INTO wash.group_group
(
child_group_id,
parent_group_id
)
SELECT
"group".group_id,
parent_group.group_id
FROM
wash."group"
INNER JOIN
wash."group" AS parent_group
ON
parent_group."name" = 'MainGroup'
WHERE
"group"."name" = 'AdministratorGroup';

INSERT INTO wash.group_group
(
child_group_id,
parent_group_id
)
SELECT
"group".group_id,
parent_group.group_id
FROM
wash."group"
INNER JOIN
wash."group" AS parent_group
ON
parent_group."name" = 'MainGroup'
WHERE
"group"."name" = 'OwnerGroup';

INSERT INTO wash.group_group
(
child_group_id,
parent_group_id
)
SELECT
"group".group_id,
parent_group.group_id
FROM
wash."group"
INNER JOIN
wash."group" AS parent_group
ON
parent_group."name" = 'MainGroup'
WHERE
"group"."name" = 'ReaderGroup';

INSERT INTO wash."user"
(
  public_user_id
)
SELECT
  user_id
FROM
  public."user"
WHERE
  (user_name = 'user') AND
  (user_domain = 'WS06');

INSERT INTO wash.user_group
(
  user_id,
  group_id
)
SELECT
  wash."user".user_id,
  wash."group".group_id
FROM
  wash."user"
INNER JOIN
  public."user"
ON
  public."user".user_id = wash."user".public_user_id
INNER JOIN
  wash."group"
ON
  "group".name = 'AdministratorGroup'
WHERE
  (public."user".user_name = 'user') AND
  (public."user".user_domain = 'WS06');

INSERT INTO wash.form
(
  "name",
  title,
  path,
  description,
  workflow_type_id,
  "order",
  enabled
)
SELECT
  'WashStart',
  'Автомойка',
  E'WashStart.xml',
  'Стартовая форма бизнес-процесса "' || 'Автомойка' || '"',
  workflow_type_id,
  1,
  True
FROM
  public.workflow_type
WHERE
  workflow_type.name = 'Wash';

INSERT INTO wash.form_group
(
  form_id,
  group_id
)
SELECT
  form.form_id,
  "group".group_id
FROM
(
  SELECT 1
) AS query
INNER JOIN
  wash.form
ON
  form.name = 'WashStart'
INNER JOIN
  wash."group"
ON
  wash."group".name = 'MainGroup';