Return-Path: <linux-erofs+bounces-2877-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFodNGcFvWkO5gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2877-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 09:29:27 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA42D73BB
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 09:29:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcbMR19Fkz2yYY;
	Fri, 20 Mar 2026 19:29:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::335" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773995363;
	cv=pass; b=kbh/EyBD0B+IEiCgBi/s8PZ6OLcfiJrYoZ9Z1fddX6eGzK+nTzk1t8oaNlpyE1hkPolxotDgtIH/vzrucP849GltYEI5eTkQ9aNuNBqlck6+UC78JIgEvqptDAXXtDD+p6aauum70VxPqDLdPfzDek9qEOoasHyjX4xMFQK7cBT/cLpU7hFbSgKmNoyGuYmf8818Myjln6IrDZIjY6WxjJoYWDDDiEy/nu/t6Pnj7D4PihpZeeOwkwEnFjOyvkDik8tDp3zuyPYM1ja/HkgFmJgaSo7YkIduzJXVZx41RJPo4GTYLUKFGAHtNn//u9KGPSP371JjetU2e1lBoP98fA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773995363; c=relaxed/relaxed;
	bh=WKyEcpWNbc9W7P9F4fh9bcZhM47oaMO4CmAOdC5dxTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhvRET6fS3Wdw4XVQN3R6EUZc3CMpR55lux6+rPOay6nZgDS47STcwcLnM4WWcjIvBJT29b5YmAKt8CGOE8AosH0kOmz2/gBeqKDjnH3+UfK2bHI/LUGT601Fy/+1e+Sff2yIROaMCLMcwvYN8mfv8U5KgcEcvNgy//w3/YOGp6LqSarVwTMdKdq6z/U4XckmA/QV8fIDDNcKpBISQDxYSv4lfcJccKr+Wx8/9Wg9dN+11QqkH0GqfMTKyJqd9O7exaiGVXN9CFOq8OvRAu0dMcJIFliHcswWMhcZOQFw3p/aYxmiOGQeWM8TcyanZ1OmjuAdPufuczCGJrXCdYA9A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FMgdvfaN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=smsharma3121@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FMgdvfaN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=smsharma3121@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcbMQ2DfFz2yY9
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 19:29:22 +1100 (AEDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-7d74c892c3bso320764a34.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 01:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773995358; cv=none;
        d=google.com; s=arc-20240605;
        b=HEFH368CFp1dstbTk6CLs5gZfmfE6LFt3g0/IPyzIAB/3tI/V19e+CrPTdi/81UHIf
         4QZgZnyBx/PJescHlxlW4AVg4v/FU7EEGMzVc+H324AQbkXGGjdmZh70AR87aZ/gFTUU
         s/370gm2Db8l1uPmXoQfYohz5dGqxguWRjEyyS5mY0G3oQ/tsDkVPPSVtafdKWvH7O5e
         SQj0gjU1K7Sd02YskX3MqcpSRaPjbSVimnrp88DlK9qziwLfpovfCvUCq0HSfJfyrvrq
         a6hkjz1/u1sJSDlC+azRrEphOUlbBZVnV1Jy4RQgUJXSeWqVdtIZKbW7lFBHiN1n1l8m
         l3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WKyEcpWNbc9W7P9F4fh9bcZhM47oaMO4CmAOdC5dxTs=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=U3fKOAo52KRNYYgIqviSN0mG+zYZXJIGfveU66j+/fO7Z0ZpL6D61RsDaSGZOPEzmf
         SD6Vtecgl7ytHqTzXx/4YQMpKO78RLyQ3Xu2XhKfhhGW0ZllyYxUZ/XAnkZQq7x8vyTB
         egYKwbM3T2WbeKkcK9oq1yt+nSpaoO/XyUUvdHvf08pN4eSQRasRdHHyfs/7onvsc4Ye
         roai0OEjb0fq60WQvDKmh/7Hr4lldAPZ/SwgnW4byLq+agZftFwAfFR4J2femo2i1iNz
         ME2B471+rEelfvEKOkJO+FxPvVtdGDs3lDJAXPprkVxTwwlruIqcOOJ/4gW+DFx85/HX
         Mfsw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773995358; x=1774600158; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WKyEcpWNbc9W7P9F4fh9bcZhM47oaMO4CmAOdC5dxTs=;
        b=FMgdvfaN7IFaYaaqDF/9iCc4egFuhujZ3PNTckgJxHrMmu8c3nnm+uXNPWpvkXBKR3
         3vrcQ1XYTbLpMYz3C8HNq4i+/to6C5h1xNi35hOclsVohhmP3qq8Tl3W82In0Rqd3Lwv
         PCHE8E5Yv+fx+BuyRZQ9e5MJXu+8z0fS21OdUn2yHLUELRcf7CXIhufcuMkykGzKXt+K
         W6d9jV5enkQ7RIKYz9NI+CUwyFfFDkg7DeImTekMJVrBOI8XjiiEwAZom5PXIpVju2qG
         p+0HGrKCLUYVhVr/IWRAofX0J7N4aIPgh70pbROkIXa48qwYKfXXfVn0s5ckmUIk/i+8
         RpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773995358; x=1774600158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKyEcpWNbc9W7P9F4fh9bcZhM47oaMO4CmAOdC5dxTs=;
        b=VggIM7Vc02kMXFperpu+akV55/ot8wycH4unyRUPXz0ei7bEBpcrmsIF87K/qi6F/v
         JCT/DzrEftJo6DziAbMrqO2hghQ16GmxA/qVciQ6qySaMNVUjfLvWnIljW+J+o/q7cl/
         JfodYKca2YktDlNY5KjYbfWxINYNoRJXH/wQmWStop1egG/4N+uFgNlkJFrEwDZ9Z2Wq
         6qafFLzsUsp8ingvgJBKcgTEmhnBzw3J06VsQG6dzd47BsEetbKUtYWBS/6q7UbnA16t
         QYR5W9/DJhSbYwrb9gmZ0Diqix9HrscToaf9Ou9jN0noVIWm1zN7ErOyDkzhdqM7/8Cw
         EcSA==
X-Gm-Message-State: AOJu0YzsyxnMtzXyP0kyr3ch1bmFEdywlAiUw5R4Z2PFFMPkBDTWLY7m
	m2YysXuSZyFrquiNU7ptDG3D2qEAmOiHiGSfBAabDnqIVxdWv2TmyTK6OU/3wz7drlGGyXtoVhA
	tgD3l4qbsGVDc7WJVnCfTR/deQPpdLVo=
X-Gm-Gg: ATEYQzyyjZgm0lBZbntKFqLnrJd8gTy59hDJwfembBlWZ56lXtrwFFJIeub99TrL4ZY
	lg2+Qz+CPv4JLPgsZ1CyhgOOuoM02YoJjuD6FKu1JP71pcZqJM9O4qKB5xiCgl9VPX2RWxajgl3
	ugVMKiftnyi3l1N35KBPz562CvkWfsSFFwWMdOL6cCVIRWU6FCfQ4aemhMsXAB7b026anCUbroQ
	/4cuNroZjhVtZ9MyzuyX1DNTz3EMtZvCyXGc2Ysa03a8FacKy2klzsRReY3A+ItgiBdDc1t9xsL
	yTgIvHyfshGVRiBT77zfE4PTkjaxPkdR4b4nc78t
X-Received: by 2002:a05:6870:5e13:b0:417:1a62:17d5 with SMTP id
 586e51a60fabf-41c11481aaemr1037886fac.7.1773995358288; Fri, 20 Mar 2026
 01:29:18 -0700 (PDT)
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
References: <20260320015947.2325-1-smsharma3121@gmail.com> <7f6d31c2-67f5-4233-91eb-13385582c300@linux.alibaba.com>
In-Reply-To: <7f6d31c2-67f5-4233-91eb-13385582c300@linux.alibaba.com>
From: Shubham Vishwakarma <smsharma3121@gmail.com>
Date: Fri, 20 Mar 2026 13:59:07 +0530
X-Gm-Features: AaiRm51zRDgychvtTd_4U9Zmg33O2X_gJxxGhIuggfdgH1KI7N3ziiCoQWuwTKs
Message-ID: <CAPs1YC5Hu78WJMBz2cKh16fKo=brGc6eow7TLiGu+FnjDMjmWg@mail.gmail.com>
Subject: Re: [PATCH v3] erofs-utils: decompress: fix QPL job leak on error paths
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000029fea3064d707b66"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[smsharma3121@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-2877-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.930];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smsharma3121@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: CACA42D73BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000029fea3064d707b66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gao,

Got it. Thanks for applying.

Shubham Vishwakarma


On Fri, 20 Mar 2026 at 11:00=E2=80=AFAM, Gao Xiang <hsiangkao@linux.alibaba=
.com>
wrote:

>
>
> On 2026/3/20 09:59, Vi-shub wrote:
> > Two early returns in z_erofs_decompress_qpl() after a successful
> > z_erofs_qpl_get_job() skip the cleanup, leaking the job handle.
> > Use goto out_inflate_end instead.
> >
> > Signed-off-by: Shubham Sharma <smsharma3121@gmail.com>
>
> LGTM, will apply.
>
> Thanks,
> Gao Xiang
>

--00000000000029fea3064d707b66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<span class=3D"smart_draft_text">Hi Gao,<br><br>Got it. Thanks for applying=
.<br><br>Shubham Vishwakarma</span><div><br></div><div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, 20 Mar 2026 at 11:00=E2=80=AFAM, Gao Xiang &lt;<a href=3D"mailto:hsiang=
kao@linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:r=
gb(204,204,204)"><br>
<br>
On 2026/3/20 09:59, Vi-shub wrote:<br>
&gt; Two early returns in z_erofs_decompress_qpl() after a successful<br>
&gt; z_erofs_qpl_get_job() skip the cleanup, leaking the job handle.<br>
&gt; Use goto out_inflate_end instead.<br>
&gt; <br>
&gt; Signed-off-by: Shubham Sharma &lt;<a href=3D"mailto:smsharma3121@gmail=
.com" target=3D"_blank">smsharma3121@gmail.com</a>&gt;<br>
<br>
LGTM, will apply.<br>
<br>
Thanks,<br>
Gao Xiang<br>
</blockquote></div></div>

--00000000000029fea3064d707b66--

