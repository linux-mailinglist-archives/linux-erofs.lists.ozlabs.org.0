Return-Path: <linux-erofs+bounces-3883-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RY1SO7OcVGr8oAMAu9opvQ
	(envelope-from <linux-erofs+bounces-3883-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 10:07:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B347487FA
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 10:07:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=POjcks6k;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=POjcks6k;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3883-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3883-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzFQk01Jtz2xjN;
	Mon, 13 Jul 2026 18:07:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783930029;
	cv=none; b=Pi2GwSUoR0xkZI15LJi49WC10omXN3AGsl+sSIDjGb8b/5XxJX+VZdwv3Yp1KGdc4D+90DomXHCqHaIzUJK9N3CXgwwqugFCVe5HoTJRRYxkv5LVY+uoDzRpPtgSYzepBiE7i4ox/zJLRhdpJMTQ7CL72fMMXFRdUj92YzXIHPxPJLYedS2FGEz7aViKaZ+9vFeAwN9p4UudK8Z+a/ZTw4OHRrTTjXwmGqxpE8fqo/McyAiOKE9Yk8gF34Y6YrcDF6L/LA//frkx1IuZkuq4p4BjsRtHNTjK6lg9pOaTHTZQy0LkX04/NxF2E+Re/W4dP+cXAkMTtdpPBFgNQf8y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783930029; c=relaxed/relaxed;
	bh=/4wY4RWP4QXhnzIcRy9eHDGE2HmFl9OBs3bjfxxy2g4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJl4N+59utbZwKtTniaUtwWX41xNc9kWcG77xDkWVmEJtMbagcGW9fOUlYa1JZ459Qrw6Ukrn3S9g/li4Op/ddV4dBd8YTVCwMREgo9r7wiuvtkkgCaVB2esOoTyBQF7WxQcUr8rTuaj6i6xbmGrYegkoww7bW1CoN5ONr8cD8L48v+P4l+Ylrg1xNMogk+6B0v/MBEiBVoaZZN3+cU16BEUYb/NrLshP6CZnC/bIQG31ecbJZsQlX/1xkrHihXs9IyY8848DgjY+V4wJ/Y6AQ4nYVzDUexKm+lVUvkKkO53WvLukOBXMU2M5jw4urw+H3wNhbYGBgd40DQa0y9DUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=POjcks6k; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=POjcks6k; dkim-atps=neutral; spf=permerror (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=gscrivan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzFQh3586z2xRw
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jul 2026 18:07:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4wY4RWP4QXhnzIcRy9eHDGE2HmFl9OBs3bjfxxy2g4=;
	b=POjcks6k7bMObl2uE/71LlxGoUDlCUCwre77DWJkksxbr7vxkttDCqN6aWECjHSJB77mK7
	EL2IRRG3qz84zX7EJbTbkIy2bsD+tO7Bz8LYASefIgwajH7Zp2TeaBDfkequ8W5Eiui9G+
	bDdeHAf+/8q3YWm5uVI+fSyL4ZYg2qA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4wY4RWP4QXhnzIcRy9eHDGE2HmFl9OBs3bjfxxy2g4=;
	b=POjcks6k7bMObl2uE/71LlxGoUDlCUCwre77DWJkksxbr7vxkttDCqN6aWECjHSJB77mK7
	EL2IRRG3qz84zX7EJbTbkIy2bsD+tO7Bz8LYASefIgwajH7Zp2TeaBDfkequ8W5Eiui9G+
	bDdeHAf+/8q3YWm5uVI+fSyL4ZYg2qA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-jjp8OdHTOKujZDzlc68Ukw-1; Mon,
 13 Jul 2026 04:06:58 -0400
X-MC-Unique: jjp8OdHTOKujZDzlc68Ukw-1
X-Mimecast-MFC-AGG-ID: jjp8OdHTOKujZDzlc68Ukw_1783930017
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09E7A1955DDC;
	Mon, 13 Jul 2026 08:06:57 +0000 (UTC)
Received: from localhost (unknown [10.44.33.216])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FFA2180058F;
	Mon, 13 Jul 2026 08:06:55 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-erofs@lists.ozlabs.org,  linux-fsdevel@vger.kernel.org,  Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
In-Reply-To: <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
	(Aleksa Sarai's message of "Mon, 13 Jul 2026 14:52:25 +1000")
References: <20260711071137.4130824-1-gscrivan@redhat.com>
	<2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 13 Jul 2026 10:06:54 +0200
Message-ID: <871pd748kh.fsf@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: KI4O40JnEUzQv7LbxHR_H-Elw4v0UcUfX0Mx-s7pJgM_1783930017
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-Spam-Flag: YES
X-Spam-Status: Yes, score=4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_FAKE_RF_SHORT,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,
	SPF_HELO_PASS,T_SPF_PERMERROR autolearn=disabled version=4.0.1
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
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [54.186.198.63 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [170.10.133.124 listed in list.dnswl.org]
	*  1.0 GB_FAKE_RF_SHORT Fake reply or forward with url shortener
	* -0.0 RCVD_IN_MSPIKE_H4 RBL: Very Good reputation (+4)
	*      [170.10.133.124 listed in wl.mailspike.net]
	* -0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
	* -0.0 DKIMWL_WL_HIGH DKIMwl.org - High trust sender
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3883-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cyphar@cyphar.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyphar.com:email,youtu.be:url,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24B347487FA

Aleksa Sarai <cyphar@cyphar.com> writes:

> On 2026-07-11, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 86fa5c6a0c70..3040d4cf9b85 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>>  enum {
>>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
>> +	Opt_source_fd,
>>  };
>>  
>>  static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>  	fsparam_flag_no("directio",	Opt_directio),
>>  	fsparam_u64("fsoffset",		Opt_fsoffset),
>>  	fsparam_flag("inode_share",	Opt_inode_share),
>> +	fsparam_fd("source",		Opt_source_fd),
>>  	{}
>>  };
>>  
>> @@ -524,6 +526,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>  		else
>>  			set_opt(&sbi->opt, INODE_SHARE);
>>  		break;
>> +	case Opt_source_fd:
>> +		if (sbi->dif0.file)
>> +			return -EINVAL;
>> +		sbi->dif0.file = get_file(param->file);
>> +		break;
>
> I don't think this handling is right for a few reasons:
>
>  1. AFAICS this shadows the default "source" handling logic (because
>     -ENOPARAM is not returned for the non-fd case), which means that
>     this regresses existing erofs users -- everyone already uses
>     "source" today. I must really be missing something if this worked
>     when you tested it.
>
>     Additionally, fsparam_fd unfortunately permits strings (where the
>     string is the numerical value of the fd number), meaning that this
>     will call get_file(<garbage>) if someone uses FSCONFIG_SET_STRING.
>     You will need to check param->type at least to avoid that.
>
>     I meant to send a patch for this earlier this year, but a nicer
>     solution would be to have a custom helper similar to fs_lookup_param
>     except that it permits FSCONFIG_SET_FD, FSCONFIG_SET_PATH,
>     FSCONFIG_SET_PATH_EMPTY, and FSCONFIG_SET_STRING. This is sorely
>     missing and people keep accidentally creating unusable interfaces as
>     a result. I mentioned this in an LPC talk last year[1].
>
>     proc_parse_pidns_param was my minimal version that only accepts
>     FSCONFIG_SET_FD and FSCONFIG_SET_STRING, and if you don't want to
>     add dirfd support yet then you should use something more like that.
>
>  2. On a slightly less critical note, fc->source has special handling in
>     the VFS in a few places and AFAICS this is the first example of
>     someone adding an implementation of "source" that does not set
>     fc->source to a proper value, which deserves some additional review.
>
>     (At at quick glance it seems this just means that some stuff in
>     procfs will show as "none" rather than fc->source debugging, but
>     again it probably needs a closer look.)
>
> [1]: https://youtu.be/NX5IzF6JXp0?t=72

sorry, I underestimated the blast of the patch.  I didn't realize it
changes the default handling and that is why I've limited my testing to
the new case only.

Would you be fine if I amend the following fixup?

It addresses both the issues you've reported.  An EROFS image file
mounted via its path still works and shows correctly in mountinfo and
"source" is also populated when mounting from a file descriptor.

# /root/erofs-test/erofs-mount-via-fd /root/erofs.blob /mnt
# grep /mnt /proc/self/mountinfo
671 42 0:83 / /mnt ro,relatime shared:666 - erofs /root/erofs.blob ro,seclabel,user_xattr,acl,cache_strategy=readaround

# mount /root/erofs.blob /mnt/
# grep /mnt /proc/self/mountinfo
671 42 0:83 / /mnt rw,relatime shared:666 - erofs /root/erofs.blob ro,seclabel,user_xattr,acl,cache_strategy=readaround

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3040d4cf9b85..7818872ab1e5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,7 +386,6 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
-	Opt_source_fd,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -414,7 +413,6 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag_no("directio",	Opt_directio),
 	fsparam_u64("fsoffset",		Opt_fsoffset),
 	fsparam_flag("inode_share",	Opt_inode_share),
-	fsparam_fd("source",		Opt_source_fd),
 	{}
 };
 
@@ -447,6 +445,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	struct erofs_device_info *dif;
 	int opt, ret;
 
+	if (strcmp(param->key, "source") == 0 &&
+	    param->type == fs_value_is_file) {
+		if (sbi->dif0.file || fc->source)
+			return -EINVAL;
+		sbi->dif0.file = get_file(param->file);
+		return 0;
+	}
+
 	opt = fs_parse(fc, erofs_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;
@@ -526,11 +532,6 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
-	case Opt_source_fd:
-		if (sbi->dif0.file)
-			return -EINVAL;
-		sbi->dif0.file = get_file(param->file);
-		break;
 	}
 	return 0;
 }
@@ -779,6 +780,18 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 			return PTR_ERR(file);
 		sbi->dif0.file = file;
 	}
+	if (!fc->source) {
+		char *buf, *p;
+
+		buf = kmalloc(PATH_MAX, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		p = file_path(file, buf, PATH_MAX);
+		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
+		kfree(buf);
+		if (!fc->source)
+			return -ENOMEM;
+	}
 	if (!S_ISREG(file_inode(file)->i_mode) ||
 	    !file->f_mapping->a_ops->read_folio) {
 		errorfc(fc, "source is unsupported");

Regards,
Giuseppe


