Return-Path: <linux-erofs+bounces-2520-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAiSMSCxqWlXCgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2520-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 17:36:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91538215786
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 17:36:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRZth4tJQz3c5y;
	Fri, 06 Mar 2026 03:36:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f35" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772728604;
	cv=pass; b=XNKhPaYz5p+t/VU/6wOMY9Lyulj/50GAkrma4SPpFcSAqY2JZq2YlP+LwJL85+gHhA/T4N6ooz/AeuFdmdWiHa/SVih8pK0Q6Jsnyu365z9WVQl6k7fhNhSOVJPc7gSG4n5YbVYoLxST5FrhfsbYS//cLE0v20nCienZAS9wi4uKR6gi+9oOOefHhNrpNv00uW9I7PcotMCHhlg4uh5KrRwJplTvdyq4d+Jj5k7dhebprRPPFuf/4mK1qUHcKQglXpspQ8ZZSHkp/2bKvXUZpKWwg7/pcFRkYcPArIZahioY0jMjX0PqtPTI5VwiY2RwEJf2A6xrUxxYZWV3HmC+0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772728604; c=relaxed/relaxed;
	bh=Y+EoJNbJgnaalyGn3AZvEDmmACB7orrRYD8moWAYDaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWYEJniq465er59W4XS0DWq1O4JdFi5L86n3Yc1hOeeidLJdUaoz1Tsio8mDIC0WSgQ2LeH1RXg3Cij1mx12HHtHLKtWSj7dseudrBMqOEmlr+C2NNUPu/Gb3aj88gdlOyiMip1rGFXUUxVHprZCKWz/GeJp1GTmQYPKkjJ98L1rkE6lGNB7tqpd9SeF5Clkh8U4eRkLHqDadv7COkK5XM1Var8FObFCXwJTEutT9IKxybk+GUur7qHS0v+XvsuItv81/WLy/wlqJsz6rh0E+06NyhhhyV13fnaPW9JHqqIkpmuWfbgea8uJuxznJdpZESgaCYATD/QSE7hROTi2cg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z6lwU2Mm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z6lwU2Mm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRZtd5fn7z3c5f
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 03:36:40 +1100 (AEDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-899fc4de46eso9256226d6.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 08:36:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772728598; cv=none;
        d=google.com; s=arc-20240605;
        b=j4QOYpBstZsyV9jw13jS3pd8IpL/wbjBI2mP5EtTcMyCE0nGjdYIo7HBIbuT9GgZIb
         /xg/iFulkkINeYICxYqttCSQ5WyVUXNz1zO5s1oMNHn17GLQAtrTOrDLU02TVMcgEbtf
         j6mWTjYI9PS+XQdmfwxdCzXsuBzj1IkEZRKkbjnwu+YcjUHJHRCKnsCV2Q1hq1S5+BOx
         SU86pRUApwFR7ekswM/WPU3O78tHLQxzOsooCMRQ264UY9SB3W1hpQj7MpznHF2X8/S2
         VHPm6zF8dUW4K4xLt1ZCXqAY836Dh7Lph65H+HllGolzzSAfaJcXqEo0BGL5dL2Fe6s7
         J/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y+EoJNbJgnaalyGn3AZvEDmmACB7orrRYD8moWAYDaU=;
        fh=h6uq7XjWFSBY/jwInOiPeoemBJWA2pJ/g0xZ2uxEeMY=;
        b=HjZJwNAZ2lhZpNaUV7+7EGM8rj59wRm4E/BcUmly8J4knzlitBcTBu9xueDvj5HSbJ
         7G8FP4TBkRWVcb/+zjuSarpnVYhCpO4RB2No5bmF60zJPOajz15UEfUyB73h7MW6HxOl
         wjZWAOAfyW2rrhXhHIvTGxFBHRNhWfqEk7dyOheRBZbjjiuZyJi5Hb/YI5KSKwwyIGye
         NvjgUYoZDNn7nqRootzx9mtZ3H3Iy4FKlShjeP0rvtCCdGuUBVL4bMwk0gwbxuNuEc+v
         UQXDH8k9BClAmIEbwL/Fvzcw+/eal3Uv/F5fXcm6q+aRSDimoB4FBhkOabGXp/lgOG0W
         O8FA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772728598; x=1773333398; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+EoJNbJgnaalyGn3AZvEDmmACB7orrRYD8moWAYDaU=;
        b=Z6lwU2Mm5nKDs3nSKS4v3rJiGDQ1MrSxuqQWL9X8vNKqHS/jsHsvTEhTzRkjKrt0Fw
         FE461Z2ptzm8XvsjKr1kMXiZCgtGdPpVo0Ofd6jRZlourktOvz5c/kh6WWgCXNqme5f7
         srNSki+TeY+8PKO0vsIupoiiAnlrbtIuFWPcSTZM+555zuNcfwL0FfRGXrmKGbdOPJ4W
         fxqGy/7l7bKBEVPIbmBL5DuqrBE1K+d55daACOSz5CGUJfLsfJe18YeHtm4SFZMGZ6l7
         1LEuVUXC6FXMEKD1HWp5q82WY8/iDbN/0BMHkYFn9Li34LGA4m86/gxD14u4Kj2Q3eqk
         fLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772728598; x=1773333398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+EoJNbJgnaalyGn3AZvEDmmACB7orrRYD8moWAYDaU=;
        b=jkIGIjO05omo3iSI0ooqq6wZPstBncE9iArZybTRDmkwbaKkXWY7XNY2Qaf5m+F6Lz
         MnkLYuIxADVu1qXQ7PgDiGbXsC97hPDLts0hLPoV9TEZm7EwMnaDqnZ/A7s3PFR8UhFb
         KqpwMSpekjz1/7/GJiPPvoJIJq2px/WIEhfvK5K1LTRiHSO2B6ymd21TwNPbov9i+VcC
         qKbGNQclXXOLgy4bn+HsP2gf3j2U18BL3Tt5b9oMUydMokEpR6RrkiOxFbbbbqO41u4H
         y1KpITzOmDqNbyAxzvRA7HvQo20MgLusYsj3jXaN/llwmA5cme5dCSSWA+htohORHRSr
         4c1g==
X-Gm-Message-State: AOJu0Yx1JTJerI+T59Ew1AyGyHDxgX6aGUYna51NxvOqUuNQsflNDxSn
	FGAi7v4mWHP81Y5rAaSjuK4ZS3NZAQRTJmcNi4hGzdrGQJRL4SOVFkIBv5mv3KlXQka+iurR87s
	vSfxtBzCk7GYkGkyZbI/37J4XerAQv+aYqUA1/uBGbQ==
X-Gm-Gg: ATEYQzwYAm6QIO43g3O8XSkMFeNZg9FY0BK+Pjk8dMNnCTRZtf8loGtMVXxMRFvnROh
	0HLRBQgeyfMS130UVUCKX2D34nasi3FxuhUkkno4pE5ZZriGVpNgSmbz+YCuc8pXelUgUuXiO01
	X82wCMZS8Igb6e18iMazqKIGpNmJiwAA/rHSAGBrLdrMYf/xpGSiXNHqnUULBkdsaGSOizUqFhB
	xYAem8lOU/OfbBffHscNPrU9KgYF6q1fbHd8YzHoeuUFOzTbUh3mPnW0T43FkxwLsydpH9MCqHZ
	/CMRXifFtCqsYUDABjLCJGFutyW/aCCG+eRdCZpoT346kxnnobW6Pm28o/nXBTrHVZ6e
X-Received: by 2002:a05:6214:4ec2:b0:89a:b62:2ff6 with SMTP id
 6a1803df08f44-89a19d29621mr62125846d6.7.1772728598413; Thu, 05 Mar 2026
 08:36:38 -0800 (PST)
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
References: <20260304182121.44834-1-singhutkal015@gmail.com>
 <a1f7d481-238f-468f-8b75-f069d523e497@linux.alibaba.com> <a8479135-9eca-4910-82a8-0b7589a9c5d8@linux.alibaba.com>
In-Reply-To: <a8479135-9eca-4910-82a8-0b7589a9c5d8@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Thu, 5 Mar 2026 22:06:27 +0530
X-Gm-Features: AaiRm51aWOPF9Xj0ZY2kdny20uO2GKSG3ZySoP_foOmzCLQG5_hPzDaW_rJPlaw
Message-ID: <CAGSu4WO6rLuJF5CgiJ38z=AHDrUn0KEMzyPy7_KR4c1SJU68kw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: validate inode offset bounds in erofs_read_inode_from_disk()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Content-Type: multipart/alternative; boundary="00000000000064460b064c498a31"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 91538215786
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2520-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Action: no action

--00000000000064460b064c498a31
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gao,

Thanks for the detailed explanation. I understand now that erofs_io_read()
already handles the out-of-bounds case and returns an appropriate error,
so the additional check against primarydevice_blocks is unnecessary.

I also wasn't aware that primarydevice_blocks can legitimately be 0
for dynamically generated EROFS images, so my change would indeed
break valid use cases.

Thanks again for reviewing and clarifying this. I=E2=80=99ll keep this in
mind for future patches.

Best regards,
Utkal Singh

On Thu, 5 Mar 2026 at 05:29, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>
>
> On 2026/3/5 07:45, Gao Xiang wrote:
> >
> >
> > On 2026/3/5 02:21, Utkal Singh wrote:
> >> A crafted EROFS image can contain an out-of-range node ID in directory
> >> entries or the superblock root_nid that causes erofs_iloc() to compute
> >> an inode offset beyond the image size. This leads to out-of-bounds
> >> reads in erofs_read_metabuf(), potentially crashing fsck.erofs,
> >> erofsfuse, or dump.erofs.
> >
> > Do you have a reproducible image?
> >
> > I think in that way, erofs_io_read or something should fail
> > instead, we don't need such check against
> > sbi->primarydevice_blocks.
>
> It will return:
> <E> erofs: erofs_read_inode_from_disk() Line[42] failed to get inode (nid=
:
> 249216) page, err -5
> <E> erofs: erofsfsck_check_inode() Line[988] I/O error occurred when
> reading nid(249216)
>
> I don't think such check is needed, blocks is mainly for statfs
> statistics, for dynamic generated EROFS, it could be 0 all the
> time.
>

--00000000000064460b064c498a31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gao,<br><br>Thanks for the detailed explanation. I unde=
rstand now that erofs_io_read()<br>already handles the out-of-bounds case a=
nd returns an appropriate error,<br>so the additional check against primary=
device_blocks is unnecessary.<br><br>I also wasn&#39;t aware that primaryde=
vice_blocks can legitimately be 0<br>for dynamically generated EROFS images=
, so my change would indeed<br>break valid use cases.<br><br>Thanks again f=
or reviewing and clarifying this. I=E2=80=99ll keep this in<br>mind for fut=
ure patches.<br><br>Best regards,<br>Utkal Singh</div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Th=
u, 5 Mar 2026 at 05:29, Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.ali=
baba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2026/3/5 07:45, Gao Xiang wrote:<br>
&gt; <br>
&gt; <br>
&gt; On 2026/3/5 02:21, Utkal Singh wrote:<br>
&gt;&gt; A crafted EROFS image can contain an out-of-range node ID in direc=
tory<br>
&gt;&gt; entries or the superblock root_nid that causes erofs_iloc() to com=
pute<br>
&gt;&gt; an inode offset beyond the image size. This leads to out-of-bounds=
<br>
&gt;&gt; reads in erofs_read_metabuf(), potentially crashing fsck.erofs,<br=
>
&gt;&gt; erofsfuse, or dump.erofs.<br>
&gt; <br>
&gt; Do you have a reproducible image?<br>
&gt; <br>
&gt; I think in that way, erofs_io_read or something should fail<br>
&gt; instead, we don&#39;t need such check against<br>
&gt; sbi-&gt;primarydevice_blocks.<br>
<br>
It will return:<br>
&lt;E&gt; erofs: erofs_read_inode_from_disk() Line[42] failed to get inode =
(nid: 249216) page, err -5<br>
&lt;E&gt; erofs: erofsfsck_check_inode() Line[988] I/O error occurred when =
reading nid(249216)<br>
<br>
I don&#39;t think such check is needed, blocks is mainly for statfs<br>
statistics, for dynamic generated EROFS, it could be 0 all the<br>
time.<br>
</blockquote></div>

--00000000000064460b064c498a31--

