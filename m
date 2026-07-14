Return-Path: <linux-erofs+bounces-3895-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PNSIJOAKVmqnyQAAu9opvQ
	(envelope-from <linux-erofs+bounces-3895-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 12:09:36 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 409CD75339F
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 12:09:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NgLLdPIH;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Dl3+0ewV;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3895-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3895-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzw5R5WVVz2y71;
	Tue, 14 Jul 2026 20:09:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784023771;
	cv=none; b=X4hMFBVb61+Oi1MWv4RkOuImVHeP40az9VMFcTy4lm1PF4XsCvAUlI/4iMdYeT942fZjGuoETak15dOw75MWLuzu4q+vRB750VzpV+BDwm3knYwPbPWnrJxTEBur88Hqvy71Cs+PiUt9S0biH8esjECR0FoXXhWTrXYvODY4EonP/ngYG1yKLcO0j7yAVESl9UCwU8qbwcPtj5oocvurJjD0RPlRHH8802W95UYSUnNpv3Kej0nDdJ9nucSmcS30J7JQ6VZXA3PELIBdWCAZ6Kind0BjD06RSuXONZfRFQoxzDEPWSrhVh9SQ8UwSiIy1CeNidd5IvJW2lKzN3qa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784023771; c=relaxed/relaxed;
	bh=MmYNaA+5oKQvi2MwU3Go0Jq3d3s0gwtHKKIHEJ19AnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PD6/pVQanInTbRmNZt5Ux2yicuKzSn/6qSX193TYxd4i3BGvsr4F7l/bOjGJx4fXRih19797lFtPCJSa++2wI5aNhvGlsc3MNILPrrl/9jvwpe1/mTAJuMKonAV3kqE6Q+XGFC2j9tC4DE0niBvz6GEEbmZBaK9fpuPHyCLyXIyAYQcUpxwAkd2UuGPOUlebz207cdZ0x1tzvNhYzVl/u49LkzW+lL6xwuFbprsUgbZlgJS0FdzaIACFLNEx/a0jYATTLwxwaMOo8TIoGQrEznrwQJiQCjBbYewfTbkIXqgyJgIsF44sg1LQX0TcFhc7J1BKRDVMTrNs8+3xYF6QGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NgLLdPIH; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dl3+0ewV; dkim-atps=neutral; spf=permerror (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=gscrivan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzw5Q0rBCz2xqn
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jul 2026 20:09:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784023763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmYNaA+5oKQvi2MwU3Go0Jq3d3s0gwtHKKIHEJ19AnU=;
	b=NgLLdPIH2HsE6Dgh+PMzXUuuNa4jVrrxxrwIHY0bN305dwZIzItQ+1fp5G+8eSF8j9SaEY
	sHwnosC0YWmDIxMbsNsEgIyufUnWipewCi95YNe4+WgmKYP+kSWx4rYjYNFqS8UwaEL2n9
	kI3HjJG/fhMU4+TgWRijSo/GmCyUZ3Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784023764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmYNaA+5oKQvi2MwU3Go0Jq3d3s0gwtHKKIHEJ19AnU=;
	b=Dl3+0ewV9LSqGgW7B6eV7S9DstvULu8MuQcCsa9VFGHcjcAczPXvRaSonjYL37bQMHjnUc
	0n5m2K2kiCIQj/sTOZ274ROdqJcyimarL15D6KeTY5sksIoo8UUdHsbD4K8rVkvcto52a7
	jVQEpLHJN176pNSS+V5Iz83xpe3/iYw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-QxCFutWdMkyQ192Lumsu-g-1; Tue,
 14 Jul 2026 06:09:19 -0400
X-MC-Unique: QxCFutWdMkyQ192Lumsu-g-1
X-Mimecast-MFC-AGG-ID: QxCFutWdMkyQ192Lumsu-g_1784023758
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74B6D1956051;
	Tue, 14 Jul 2026 10:09:18 +0000 (UTC)
Received: from localhost (unknown [10.44.32.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79CF31956040;
	Tue, 14 Jul 2026 10:09:17 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,  Christian Brauner
 <brauner@kernel.org>,  linux-erofs@lists.ozlabs.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
In-Reply-To: <c812e638-8a66-4dc0-b8d9-c971134bb413@linux.alibaba.com> (Gao
	Xiang's message of "Tue, 14 Jul 2026 14:45:09 +0800")
References: <20260711071137.4130824-1-gscrivan@redhat.com>
	<2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
	<871pd748kh.fsf@redhat.com>
	<2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
	<87wluz2nnc.fsf@redhat.com>
	<2026-07-14-drafty-folded-woes-volumes-Z93P4V@cyphar.com>
	<ba9cf493-45c8-45e8-9e21-9731ec492030@linux.alibaba.com>
	<87pl0q2i2r.fsf@redhat.com>
	<c812e638-8a66-4dc0-b8d9-c971134bb413@linux.alibaba.com>
Date: Tue, 14 Jul 2026 12:09:15 +0200
Message-ID: <87ldbd3mt0.fsf@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: YE2Eu85m_WplrkPoam2tfGsjt5bFz6qoOYTKUzejtC4_1784023758
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_PASS,T_SPF_PERMERROR
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
	*  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [54.186.198.63 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [170.10.129.124 listed in list.dnswl.org]
	* -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
	*      [170.10.129.124 listed in wl.mailspike.net]
	* -0.0 DKIMWL_WL_HIGH DKIMwl.org - High trust sender
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:cyphar@cyphar.com,m:brauner@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3895-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 409CD75339F

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> On 2026/7/14 14:36, Giuseppe Scrivano wrote:
>> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
>> 
>>> On 2026/7/14 08:49, Aleksa Sarai wrote:
>>>> On 2026-07-13, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>>>> thanks for the hints.
>>>>>
>>>>> I'll prepare a v3 if you are fine with the version below:
>>>> No worries, and this seems more reasonable at a first glance.
>>>>
>>>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>>>> index 86fa5c6a0c70..72c85cc53085 100644
>>>>> --- a/fs/erofs/super.c
>>>>> +++ b/fs/erofs/super.c
>>>> ...
>>>>> @@ -437,6 +439,38 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>>>>>    	return false;
>>>>>    }
>>>>>    +static int erofs_fc_parse_source(struct fs_context *fc,
>>>>> +				 struct fs_parameter *param)
>>>>> +{
>>>>> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>>>>> +
>>>>> +	if (fc->source || sbi->dif0.file)
>>>>> +		return invalf(fc, "Multiple sources");
>>>>> +
>>>>> +	switch (param->type) {
>>>>> +	case fs_value_is_string:
>>>>> +		fc->source = param->string;
>>>>> +		param->string = NULL;
>>>>> +		return 0;
>>>>> +	case fs_value_is_file: {
>>>>> +		char *buf, *p;
>>>>> +
>>>>> +		sbi->dif0.file = get_file(param->file);
>>>> A very minor nit, but you can actually steal the file reference here
>>>> with
>>>> 		sbi->dif0.file = no_free_ptr(param->file);
>>>> A few other places do this. (You'll also need to change the
>>>> param->file
>>>> reference below.)
>>>>
>>>>> +		buf = kmalloc(PATH_MAX, GFP_KERNEL);
>>>>> +		if (!buf)
>>>>> +			return -ENOMEM;
>>>>> +		p = file_path(param->file, buf, PATH_MAX);
>>>>> +		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
>>>> I think that /proc/self/fd/%d would be a more useful name for
>>>> debugging
>>>> if file_path() fails (not that it is really possible here AFAICS). But
>>>> I'm not really too fussed.
>>>
>>> Not quite sure if we should get in agreement with the format of this
>>> one in advance (IOWs, users use source_fd and how fc->source looks like;
>>> since other fses may follow the same practice if source_fd becomes common
>>> later) since it's a user-visible field and I believe we shouldn't treat
>>> this one as a dontcare field as some pseudo fses (since those fses don't
>>> rely on `fc->source` by design but typically EROFS can rely on.)
>>>
>>> I hope Christian and others could share move thought on this part too
>>> before I land this feature for the next cycle.
>> would it be better to just return the error from file_path without
>> any
>> fallback?
>
> I hope Christian or other vfs folks can decide how to handle fc->source
> string here, since in the long term, how to deal with source_fd should
> be unique among different fses: just our current short-term
> implementation lands into erofs directly for file-backed mounts to
> fulfill composefs needs.
>

overlayfs is already handling such a case, and it resolves the path using d_path:

static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
			   enum ovl_opt layer)
{
	struct path layer_path __free(path_put) = {};
	int err = 0;

	switch (param->type) {
	case fs_value_is_string:
		err = ovl_kern_path(param->string, &layer_path, layer);
		if (err)
			return err;
		err = ovl_do_parse_layer(fc, param->string, &layer_path, layer);
		break;
	case fs_value_is_file: {
		char *buf __free(kfree);
		char *layer_name;

		buf = kmalloc(PATH_MAX, GFP_KERNEL_ACCOUNT);
		if (!buf)
			return -ENOMEM;

		layer_path = param->file->f_path;
		path_get(&layer_path);

		layer_name = d_path(&layer_path, buf, PATH_MAX);
		if (IS_ERR(layer_name))
			return PTR_ERR(layer_name);

		err = ovl_do_parse_layer(fc, layer_name, &layer_path, layer);
		break;
	}
	default:
		WARN_ON_ONCE(true);
		err = -EINVAL;
	}

	return err;
}

If there are no objections, I'll change the code to match what overlay
does and return the error instead of using a fallback.

Regards,
Giuseppe


