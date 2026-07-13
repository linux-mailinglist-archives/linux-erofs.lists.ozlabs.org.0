Return-Path: <linux-erofs+bounces-3886-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RgzxJdm8VGp1qQMAu9opvQ
	(envelope-from <linux-erofs+bounces-3886-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 12:24:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95449749C19
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 12:24:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=XRpBEOWS;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=XRpBEOWS;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3886-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3886-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzJT12sZPz2yMm;
	Mon, 13 Jul 2026 20:24:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783938261;
	cv=none; b=MfEKnDYFrQBrr25oqVqPmfQ4QksgHxqks49wohioAzU0iJ+rjqqqSCpDNx9OO46yOIqkbySnqmgSk0Ry1VIrPLltDO+1RSD7j++VR3p1Ovbdv0/WBaRCA2fZGvMbHG5ARNcfwg7k7uytBJb8KwmcQ6lCm3WfE29b6NwhFGms2UEh9CgFgiD3rBLBrHztUHsL0M/TpnjaZevaGKa8k3kTEwl5hBnKKjboiznPW3hT3o1WpF3EIS4nGhNIqJW517kyO/Ryqc8xdaXlSaKcYzHXUaEWc865OSnepSt1Vp4ElysiUYKJ+DXIzXtbRWYCcRkYrM3h4/kXk/rIbxjAI/byNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783938261; c=relaxed/relaxed;
	bh=r4/TX7BTpjZY4DlYI5thl0aKFZApPkQRFTRSMk72/cI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RoeFfjn3LB6ccBVd7oqa51rq2zK+p9E7VwbBDbibQqiKEUDyD63XXFAHktxxmQoW8egOMFPNUD0rnrp6eKT1pnv6uuDcIPFj1pXjlMuaidUfnuLSuiG8Am8Yb1x4JV7AQFJwhRslFatLZn1tcxXTqeN98jvdpbVGRitzlQXH+OKyQ8kcOU9K5lAOtTRIblkbDaAdvGH82bZypH9QxWWZR8SdHXmMQAP/fGTrzwwYwaXiRfnYPFAUqG7waW7gpDiKPFxV07HU31KYFjJf5RfxO4jH9Knz1Z/wyqvmMrkCvmfRvT7CVGl6fBVpoMLjxByn4pTkm9WI3WMNELwWPcUN5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XRpBEOWS; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XRpBEOWS; dkim-atps=neutral; spf=permerror (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=gscrivan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzJSz6bYlz2xjN
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jul 2026 20:24:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783938254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4/TX7BTpjZY4DlYI5thl0aKFZApPkQRFTRSMk72/cI=;
	b=XRpBEOWSIOr+/OX4C8OhXL11IYbAeaOwBfQoKNUcBYeGahalnUu+M2NE/vC2wusD7u+h9L
	mI/eWtiQv1r1sRvWntjT3ZrIGhNXHh3Tt8RPPFfq9Hn01n3wV4Z4kF29dlbYahCO8w2ElX
	VYibBTsRxuM3G3eVi2pC1TCRiSKHHmM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783938254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4/TX7BTpjZY4DlYI5thl0aKFZApPkQRFTRSMk72/cI=;
	b=XRpBEOWSIOr+/OX4C8OhXL11IYbAeaOwBfQoKNUcBYeGahalnUu+M2NE/vC2wusD7u+h9L
	mI/eWtiQv1r1sRvWntjT3ZrIGhNXHh3Tt8RPPFfq9Hn01n3wV4Z4kF29dlbYahCO8w2ElX
	VYibBTsRxuM3G3eVi2pC1TCRiSKHHmM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-5HXs3xKSOE-PL7mtLAzyDw-1; Mon,
 13 Jul 2026 06:24:11 -0400
X-MC-Unique: 5HXs3xKSOE-PL7mtLAzyDw-1
X-Mimecast-MFC-AGG-ID: 5HXs3xKSOE-PL7mtLAzyDw_1783938250
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9A421955D5E;
	Mon, 13 Jul 2026 10:24:09 +0000 (UTC)
Received: from localhost (unknown [10.44.33.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2863830001A1;
	Mon, 13 Jul 2026 10:24:08 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-erofs@lists.ozlabs.org,  linux-fsdevel@vger.kernel.org,  Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
In-Reply-To: <2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
	(Aleksa Sarai's message of "Mon, 13 Jul 2026 18:33:51 +1000")
References: <20260711071137.4130824-1-gscrivan@redhat.com>
	<2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
	<871pd748kh.fsf@redhat.com>
	<2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
Date: Mon, 13 Jul 2026 12:24:07 +0200
Message-ID: <87wluz2nnc.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: oUgVz9w0-vHk3oLzkxp5kO_CuyrlGsP_3kZ5yQ_ddkg_1783938250
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
	T_SPF_PERMERROR autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
	* -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [170.10.129.124 listed in list.dnswl.org]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [54.186.198.63 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_MSPIKE_H3 RBL: Good reputation (+3)
	*      [170.10.129.124 listed in wl.mailspike.net]
	* -0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
	* -0.0 DKIMWL_WL_HIGH DKIMwl.org - High trust sender
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3886-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cyphar@cyphar.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95449749C19

Aleksa Sarai <cyphar@cyphar.com> writes:

> On 2026-07-13, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 3040d4cf9b85..7818872ab1e5 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -386,7 +386,6 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>>  enum {
>>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
>> -	Opt_source_fd,
>>  };
>>  
>>  static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -414,7 +413,6 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>  	fsparam_flag_no("directio",	Opt_directio),
>>  	fsparam_u64("fsoffset",		Opt_fsoffset),
>>  	fsparam_flag("inode_share",	Opt_inode_share),
>> -	fsparam_fd("source",		Opt_source_fd),
>>  	{}
>>  };
>>  
>> @@ -447,6 +445,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>  	struct erofs_device_info *dif;
>>  	int opt, ret;
>>  
>> +	if (strcmp(param->key, "source") == 0 &&
>> +	    param->type == fs_value_is_file) {
>> +		if (sbi->dif0.file || fc->source)
>> +			return -EINVAL;
>> +		sbi->dif0.file = get_file(param->file);
>> +		return 0;
>> +	}
>> +
>>  	opt = fs_parse(fc, erofs_fs_parameters, param, &result);
>>  	if (opt < 0)
>>  		return opt;
>
> Shortcutting parsing this way is not really idiomatic, the better way is
> to create a helper -- in this case you can almost certainly just use
> very similar logic to proc_parse_pidns_param() to get something minimal
> working.
>
> Defining your own version of "source" in fs_parameter_spec is fine, you
> just need to make sure you handle FSCONFIG_SET_STRING properly -- there
> are some other examples in the tree you can look at for inspiration
> (mostly remote filesystems AFAICS). You could even return -ENOPARAM to
> fallback to the basic implementation if that makes it easier for you,
> but it would probably be better to handle it all in one place.
>
>> @@ -526,11 +532,6 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>  		else
>>  			set_opt(&sbi->opt, INODE_SHARE);
>>  		break;
>> -	case Opt_source_fd:
>> -		if (sbi->dif0.file)
>> -			return -EINVAL;
>> -		sbi->dif0.file = get_file(param->file);
>> -		break;
>>  	}
>>  	return 0;
>>  }
>> @@ -779,6 +780,18 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>>  			return PTR_ERR(file);
>>  		sbi->dif0.file = file;
>>  	}
>> +	if (!fc->source) {
>> +		char *buf, *p;
>> +
>> +		buf = kmalloc(PATH_MAX, GFP_KERNEL);
>> +		if (!buf)
>> +			return -ENOMEM;
>> +		p = file_path(file, buf, PATH_MAX);
>> +		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
>> +		kfree(buf);
>> +		if (!fc->source)
>> +			return -ENOMEM;
>> +	}
>
> And this would also live in the parser helper.

thanks for the hints.

I'll prepare a v3 if you are fine with the version below:

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..72c85cc53085 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
+	Opt_source,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -402,17 +403,18 @@ static const struct constant_table erofs_dax_param_enums[] = {
 };
 
 static const struct fs_parameter_spec erofs_fs_parameters[] = {
-	fsparam_flag_no("user_xattr",	Opt_user_xattr),
-	fsparam_flag_no("acl",		Opt_acl),
-	fsparam_enum("cache_strategy",	Opt_cache_strategy,
+	fsparam_flag_no("user_xattr",		Opt_user_xattr),
+	fsparam_flag_no("acl",			Opt_acl),
+	fsparam_enum("cache_strategy",		Opt_cache_strategy,
 		     erofs_param_cache_strategy),
-	fsparam_flag("dax",             Opt_dax),
-	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
-	fsparam_string("device",	Opt_device),
-	fsparam_string("domain_id",	Opt_domain_id),
-	fsparam_flag_no("directio",	Opt_directio),
-	fsparam_u64("fsoffset",		Opt_fsoffset),
-	fsparam_flag("inode_share",	Opt_inode_share),
+	fsparam_flag("dax",			Opt_dax),
+	fsparam_enum("dax",			Opt_dax_enum, erofs_dax_param_enums),
+	fsparam_string("device",		Opt_device),
+	fsparam_string("domain_id",		Opt_domain_id),
+	fsparam_flag_no("directio",		Opt_directio),
+	fsparam_u64("fsoffset",			Opt_fsoffset),
+	fsparam_flag("inode_share",		Opt_inode_share),
+	fsparam_file_or_string("source",	Opt_source),
 	{}
 };
 
@@ -437,6 +439,38 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 	return false;
 }
 
+static int erofs_fc_parse_source(struct fs_context *fc,
+				 struct fs_parameter *param)
+{
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+
+	if (fc->source || sbi->dif0.file)
+		return invalf(fc, "Multiple sources");
+
+	switch (param->type) {
+	case fs_value_is_string:
+		fc->source = param->string;
+		param->string = NULL;
+		return 0;
+	case fs_value_is_file: {
+		char *buf, *p;
+
+		sbi->dif0.file = get_file(param->file);
+		buf = kmalloc(PATH_MAX, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		p = file_path(param->file, buf, PATH_MAX);
+		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
+		kfree(buf);
+		if (!fc->source)
+			return -ENOMEM;
+		return 0;
+	}
+	default:
+		return invalf(fc, "Invalid source type");
+	}
+}
+
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
@@ -524,6 +558,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
+	case Opt_source:
+		return erofs_fc_parse_source(fc, param);
 	}
 	return 0;
 }
@@ -752,14 +788,18 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	int ret;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+	struct file *file = sbi->dif0.file;
 
-	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
-		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
-			GET_TREE_BDEV_QUIET_LOOKUP : 0);
-	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
-		struct erofs_sb_info *sbi = fc->s_fs_info;
-		struct file *file;
+	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !file) {
+		int ret;
+
+		ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
+			IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
+				GET_TREE_BDEV_QUIET_LOOKUP : 0);
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ||
+		    ret != -ENOTBLK)
+			return ret;
 
 		if (!fc->source)
 			return invalf(fc, "No source specified");
@@ -767,12 +807,13 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 		sbi->dif0.file = file;
-
-		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
-		    sbi->dif0.file->f_mapping->a_ops->read_folio)
-			return get_tree_nodev(fc, erofs_fc_fill_super);
 	}
-	return ret;
+	if (!S_ISREG(file_inode(file)->i_mode) ||
+	    !file->f_mapping->a_ops->read_folio) {
+		errorfc(fc, "source is unsupported");
+		return -EINVAL;
+	}
+	return get_tree_nodev(fc, erofs_fc_fill_super);
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)

Regards,
Giuseppe


