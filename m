Return-Path: <linux-erofs+bounces-2872-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ4wMlmrvGmk1wIAu9opvQ
	(envelope-from <linux-erofs+bounces-2872-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 03:05:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D034B2D4FBD
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 03:05:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcQr10WX6z2xm3;
	Fri, 20 Mar 2026 13:05:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::329" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773972304;
	cv=pass; b=a8vqe697n8cucG6F54TlOSI+DRFMfpKeT6d1blGF7Z7/zNQFDZ0SCcWMyGH0gPIDB/2seiN6fog3+c7DDfzjcajZ+07HzjsZfHSR1FSSLveXNxKFQ6Sr0seOuTqc+dSBk3hGdbVbvrXu4UibchUnMEBYIxSQv5e1egsctz2A01r35ZkeKOv6xioknKM9AH+NA6lbq+eRylW2a3KKjzEVFKifJsYpzIGNunjLB31S/gdYgNLl6s91FrgTwugPpO7TcHOAQidzNlO5nY0e7tDwV4ZFv9r1OwRqQGl6ydpuHAf+wj4wToK1lUG2hB6RXIc4L26CgfzxgDuacADDq3BtIw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773972304; c=relaxed/relaxed;
	bh=hJpO7Fi7GCwGkJTZ3qS1tIFNnwNcTgR5F+OP/i6S6cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCszJxZyF0FqaA1BqSsYiuJO/b9Tt3A9IFHNFk0gU1L0S1zxiMST4nO/G1+qNiMwm0S23yAfJmXKP1A/uMVNXeg/tmRRy8gh8Reun0q4LKqH2DyeBnqx7hDhhqDor0JlybTAQD6OpgEQIzSx4/l63ul+9Jy7Z+whrCwNWgU2m9RqqOMoadyxbQR0M5ei0hS/AJ5HYTkmZfHWITgyFJf8myFk2tGhYpNXZ8jkHfa7jEuiADxObHSchwE2ey86y1Jk9WmNNT/RMT+o3R417JkVa/lzVdfFtXIX99LMQk9f8Q9HGl8LEkLiO60DxvyYh+sLuQQLb371TssMYBh5k76yqA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QgabmGKJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com; envelope-from=smsharma3121@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QgabmGKJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com; envelope-from=smsharma3121@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcQr02M5wz2xly
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 13:05:04 +1100 (AEDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-7d745883381so210574a34.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 19:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773972301; cv=none;
        d=google.com; s=arc-20240605;
        b=kL/HEaBvvPuxdt0xq10MCCz1pKkfRbOId57ZyEXXg4zxVRXAVgv/jGj2wffASAPYIC
         6kIb9pMb/UO9Cf1u/gZxEi9B/J+U6qAM6wrQsUhfNWkimsG04G1QU7J/yMiMLIlBTQg3
         A8VkEaTtmqWeXjoXV8SPeaxZOQY9pIXPdx17IopbXCDFhlxyWMklEA5Gmf4/edvbU++w
         XrwGl0E//Dhzy2h2K+Q6MRbdH1NC1/FGsIQgCScIGcYoMSYkEwd9dMZD3SFSKGQAcRzh
         F7ZFHdpw02ovZuVf2pjc11G6dCNmkZKhWjAKR/7KhavDbqegsR32uFj8FkmND6HQTIYE
         Oo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hJpO7Fi7GCwGkJTZ3qS1tIFNnwNcTgR5F+OP/i6S6cI=;
        fh=iLZlle6qJK8SFNde8FyK2GmGiYIMUatf5EtLuVSqlx8=;
        b=VFvtX3pXftC7ATl2Q/F5n2tlfYbM4uKW4rmJwrCq2I2Ba/tsZleCxkIShWJY1fUMB0
         p0KmUO9SLaYJgMvy8o1C1MLSLh9SIrl9oiEQYN2fBahBHd93CLJhuD1CXKMD6p+sAUm6
         Py5GgkHNpDWQvzvTNovkWKbDutUMt20ND0f3R76b8ucfJLbF2KyFEcw9gpXyXJ+7oCf1
         FH8EPoPgYNozV0XJ9y05aB6wxcEoJiyEWZ7X2NKBjuOWOQ71MgUIDpnoSRcOGJyP6NK0
         SOUjcF4JuRE9FuTwQlN5RMm0hnZm4dgfdbDZn7Rk1h9pw2anDcyVqqgJxWyUsbbnkDtC
         DL3w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773972301; x=1774577101; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hJpO7Fi7GCwGkJTZ3qS1tIFNnwNcTgR5F+OP/i6S6cI=;
        b=QgabmGKJZ4Ry4Bcg+OHBhDK1npD4KzCMtyc5BlfnGFejvteLsk7WYEMxPoHq1ujcgF
         BLngXsV5NlzbZDGmkhzU2L0qZHPX3dFQiBG7dFxt9eZ/+6EXeF993P5eZlq/9Yq5WFMT
         l8HnQ7t2Vzp/3X1CbnZbZ225tgwMrAU5/1cnj5yoYEakCpWEGUBhx4DgVynVdEtjOzKt
         9UFBJyYKGq+p1zMrae22J5w3WSWt5wrViIFWrvBFE/D7iSOLDwFNdiAE0P6B5LTM0ohg
         4H0V5scVcUTPjKwH6/CrOyNbmSOO9zu3KM7eixWRMEK5hLrb2TSsXBtIleND1cttjn5k
         hI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773972301; x=1774577101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJpO7Fi7GCwGkJTZ3qS1tIFNnwNcTgR5F+OP/i6S6cI=;
        b=nV6sENBUV8yma5xJcwohMiC3vaM45vd1kbCKBrxkjbtfUbV8T08r8bK2IZgx0/KDH0
         xTe18hzxblzjqH1CNBP2JhnGR+NWWh32bFBRS6vz38vkVPLObjnSPPgs3DuRDwyFRFDf
         Eh05nzuXhIy3jHxOE/XKryqylOgdG1aYFBw5tyrw1FAjE+6NqxTW+Wuu25Nr0lAkzcbQ
         4PEFaf+3Kt9pYT4rVpQLN50vQl7HhtpPucqywj23QUQp3d18fi+AzRE+DWcENTnK9MCP
         rVf/S0hlZUp01/dLHahMTZxyxmVd1oopeHJ7EUeWYhrwC2zS/bRMb+zeNecOvam+agpA
         g/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUHjxRjCsXzjkPqOUNFEISg2f7DAByauxt4MKQZQ3JGdsYmQrSMtb0Z5R8ityjjVb2Jyl952PEgT1n1ZA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxOdd5JSoAWB4vGj9iws2pVDD+eaA8p8K4lU6BSl/YbV27KXQIC
	mWZd+hyUOFCj0Eob4REnlL4vysyRSVuyX//ZcQG8BoR6CmuquXDoGv8zG/ui74R+PE9lEQ2Qu+X
	Jx4ExjZ03dAxQXEwRx36MVbKVWHl0ePw=
X-Gm-Gg: ATEYQzwKUOpJ9gqM1tK55Q0pIC+zhrtPlEBJQo3fyWkvLO104pmlP/TJzq3ZhhMHmKU
	i+paUrGXMCCZYBA9Cv+/lJa/hqbA/FZltFGBHH6glAYxBEXLeIF8/MexBwt4W9Kff9f5B2nJTQm
	5ohZ1k2qsNpSC+wpJsN4QcRrIWsBnM55PC1lL/1kHJu65dBEa/DSHOXAA/0KbpV6Cda1ncvzYGy
	WOGlFqm7pM7lbJPpLwjGFd14P+hemnLIVmbGSA4DLI8YNifvMjLN9+5zJI3yyPMIuM7duHmBkJW
	+/0xIpAxuw==
X-Received: by 2002:a05:6830:2685:b0:7d7:48fc:d991 with SMTP id
 46e09a7af769-7d7eaf5ceefmr893059a34.4.1773972300694; Thu, 19 Mar 2026
 19:05:00 -0700 (PDT)
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
References: <20260319221136.2126-1-smsharma3121@gmail.com> <CAMhhD9hbenqz2z2pRQ1EoSNttATsTnW9BZcgFVZ1VPCzAciHiw@mail.gmail.com>
 <0b0ad26c-f462-4274-aaad-6a8e079c0963@linux.alibaba.com> <592df2af-2109-410f-88a3-b774655f11a8@linux.alibaba.com>
In-Reply-To: <592df2af-2109-410f-88a3-b774655f11a8@linux.alibaba.com>
From: Shubham Vishwakarma <smsharma3121@gmail.com>
Date: Fri, 20 Mar 2026 07:34:48 +0530
X-Gm-Features: AaiRm50piWGnY3J7bGofknDU7eRW7OL6eeAL8WXhEMawucjrlFhgxvKyRy0gUag
Message-ID: <CAPs1YC4Us+bPMKsGAUywWcp5sWzvTX6D-+naVz1y3M6F-iwXwA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix QPL job leak on early error paths
 in z_erofs_decompress_qpl() After z_erofs_qpl_get_job() succeeds, two
 early-return error paths bypass z_erofs_qpl_put_job(), leaking the QPL job
 handle: - Line 200: return -EFSCORRUPTED (when inputmargin >= inputsize) -
 Line 205: return -ENOMEM (when malloc fails for decodedskip buffer) Fix by
 replacing the bare returns with goto out_inflate_end, which already handles
 both z_erofs_qpl_put_job() and free(buff).
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Ajay Rajera <newajay.11r@gmail.com>, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000d3070c064d6b1c55"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.80 / 15.00];
	LONG_SUBJ(3.00)[477];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2872-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[smsharma3121@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.873];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smsharma3121@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pku.edu.cn:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D034B2D4FBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000d3070c064d6b1c55
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Gao,

I understand the concern, but I want to be honest: if I had used AI to
draft the initial submission, it likely would have been sent without those
formatting errors.

The issues with the invalid email address and the oversized subject line
occurred because I was unfamiliar with sending via the SMTP CLI. I used GPT
to help me configure the CLI tool, which led to the mistakes you saw.

I appreciate the feedback on the patch. If there is still doubt regarding
my work, I will continue to submit more patches to demonstrate my ability.

Thanks,

Shubham Vishwakarma


On Fri, Mar 20, 2026 at 7:11=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com>
wrote:

>
>
> On 2026/3/20 09:37, Gao Xiang wrote:
> >
> >
> > On 2026/3/20 09:16, Ajay Rajera wrote:
> >> Hi Vi-shub,
> >> just a review :
> >> I think the fix looks correct and it is the right approach but the
> >> commit message formatting needs work. The entire description is in the
> >> subject line. Per kernel conventions, the subject should be a short
> >> one-liner, e.g: erofs-utils: lib: fix QPL job leak on early error
> >> paths
> >> The detailed explanation (which error paths leak, why, and how the fix
> >> works) should go in the commit message body, separated from the
> >> subject.
> >>
> >> So you can resend with the subject/body split fixed? so It will look
> more clear.
> >
> > yes, the commit message is in a mess.
>
> BTW, I don't know who is using the email address
> <yifan@pku.edu.cn>, and the recipient doesn't exist.
>
> Here, I want to say, I have to identfy you as another
> AI bot.
>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Gao Xiang
> >
> >> Thanks, Ajay
> >
>
>

--000000000000d3070c064d6b1c55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<div>Hi Gao,</div><div><br></div><div>I understand the concern, but I=20
want to be honest: if I had used AI to draft the initial submission, it=20
likely would have been sent without those formatting errors.</div><div><br>=
</div><div>The
 issues with the invalid email address and the oversized subject line=20
occurred because I was unfamiliar with sending via the SMTP CLI. I used=20
GPT to help me configure the CLI tool, which led to the mistakes you=20
saw.</div><div><br></div><div>I appreciate the feedback on the patch. If
 there is still doubt regarding my work, I will continue to submit more=20
patches to demonstrate my ability.</div><div><br></div><div>Thanks,</div><d=
iv><br></div><div>Shubham Vishwakarma</div>

<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026 at 7:11=E2=80=AFAM Gao Xiang=
 &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibaba=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><br>
<br>
On 2026/3/20 09:37, Gao Xiang wrote:<br>
&gt; <br>
&gt; <br>
&gt; On 2026/3/20 09:16, Ajay Rajera wrote:<br>
&gt;&gt; Hi Vi-shub,<br>
&gt;&gt; just a review :<br>
&gt;&gt; I think the fix looks correct and it is the right approach but the=
<br>
&gt;&gt; commit message formatting needs work. The entire description is in=
 the<br>
&gt;&gt; subject line. Per kernel conventions, the subject should be a shor=
t<br>
&gt;&gt; one-liner, e.g: erofs-utils: lib: fix QPL job leak on early error<=
br>
&gt;&gt; paths<br>
&gt;&gt; The detailed explanation (which error paths leak, why, and how the=
 fix<br>
&gt;&gt; works) should go in the commit message body, separated from the<br=
>
&gt;&gt; subject.<br>
&gt;&gt;<br>
&gt;&gt; So you can resend with the subject/body split fixed? so It will lo=
ok more clear.<br>
&gt; <br>
&gt; yes, the commit message is in a mess.<br>
<br>
BTW, I don&#39;t know who is using the email address<br>
&lt;<a href=3D"mailto:yifan@pku.edu.cn" target=3D"_blank">yifan@pku.edu.cn<=
/a>&gt;, and the recipient doesn&#39;t exist.<br>
<br>
Here, I want to say, I have to identfy you as another<br>
AI bot.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Gao Xiang<br>
&gt; <br>
&gt;&gt; Thanks, Ajay<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000d3070c064d6b1c55--

