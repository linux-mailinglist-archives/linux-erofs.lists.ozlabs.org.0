Return-Path: <linux-erofs+bounces-3171-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DYvJGILzmmnkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3171-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:23:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D513846A1
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:23:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmWy70NgHz2ySk;
	Thu, 02 Apr 2026 17:23:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1230" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775111006;
	cv=pass; b=ZA+Gsfu2gyZY4B0UvUJMXbE5JOxK1UmxgPluDGhT32v6Qkrhj1vnmo9CL2dx3Y/CebOM2ASzy8ged1u97ZMb/xZfrw4YYsg3mEOGeL7AZrFMAqgEVmzu3dXesZs7+O6qaTG0kF075c4OKmRc/mt4cNN0nvNRgxc1fVhGilfZjBRDogpBv2xtRyy11aW5rq6YVbpwCdJ2EdRwvUCgk8/D7T0VqMQYICEE5buR25QDj3tGYTbN0MA05LbNmzeTp1JZAuGdQE0uYltBqi9dM7DNx0mxpzrW3v/DjLlhV0Otx+dtgK5tj3aFyVQMuHSLqagYeKZfpTOSiUkBXA4MHNnnpw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775111006; c=relaxed/relaxed;
	bh=LiO+++X2XWJCNONNUVesJ9wp7nfMnqRsXWPIn4UAtw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCX6JE00/HzSdOt4kobBmx6G0dm11V4Z8TYOQf3X5BbSyjxRAYoTnQazbwwrKJUuy96u093xxs4lusxD+PWji+vbVUL0rvVKIojOG4jh87u3UFBhTdOR5BIgVkLOSmSYuMKGFKuMnoh0RP/BKw5ygLMy6XjdPcIlJVet33BnyukZNfED40f6cYBSLDcvQ/f2CgebGImuLfrccH7lO9vNMFQcWxWbhnY0xMNztt5UaQAMDvry3KmdsPnSRzNjJJLmxBeUuwgfd3BJLZLmN1PJHLPn8G2wDBAPFQhZHbRVzQ3lAMdYhVdSx3OsmzmaOw+LV5fo+aDlpSlU26QE55nnAQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rtqlo7U3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rtqlo7U3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com [IPv6:2607:f8b0:4864:20::1230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmWy60WsSz2xm5
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:23:25 +1100 (AEDT)
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-12a80c36350so684115c88.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 23:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775111003; cv=none;
        d=google.com; s=arc-20240605;
        b=EzjANtS2zU8lGRysbdThUHpbZfBVTTJpVidQmiTLx1aX4gQGaAn9LD3CNesH8JorM2
         bNNEiyAmrqmj1Deopg6WXAIaaVnlpDaXe3mmCiCTeL/jhBP7iLp8bBPo5VckS7C4fB8f
         408+u+kz7SKCZSSE4kyVlErU0MPi1gBDLm3YZ0GaZ0K/inzv+w6q5r2pU/j8e0kOk98n
         Te53Q6XwBAzGh8FeIiVA5gEXVojXHXbRxCFIg/FsbB/64cSTSWZXL3DJ8x0jQzPMPsTh
         nHBqz8yRYOjli4com69KaKBDim4KWbdpuVXgEnQ2tXtrBwtcuzMsF91l1DDIU1ExPAbj
         svFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LiO+++X2XWJCNONNUVesJ9wp7nfMnqRsXWPIn4UAtw4=;
        fh=LZpQ+M6X/sV6F7y3n84UylZ8eAXCy7Q6Ia5ljS5i3u8=;
        b=QeZs03wQVbNfbgq+wX7hXs5Ou4FgH8drdNU48mbcSunZ3KbcLOAt+UPqQAkA3+b39h
         FbptstgoB7wSSDZMh/pSS3GZ0BYOyRCD2YBP2g/L6Hz6iyPUtVXwPZNyamkXzczz+xSX
         P98cyAa/+3bUP8L3Fg5O7lsKgLy4A/1on4ZC9NUfqo71CZvFpAN3YvIZBe1NMIbDk4RS
         f36B1Kb/qiE8DaMBU7P3BDEp2BDx4vJHlEhMVm723bsiht0E0Hsdio+6XejU1vHGUjrG
         /gyoSqtXOQs5c6E2JQ1T5mKd8sa3Uoh0SwgTR064O3hE2qak6TTBKFMH6arAviMMaO7w
         Qqdg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775111003; x=1775715803; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LiO+++X2XWJCNONNUVesJ9wp7nfMnqRsXWPIn4UAtw4=;
        b=rtqlo7U3cWQ2VaztnVbMy4U9xmqQs8LUd/Akd4STPnfM76Hwj82vfRCZ1llfUBEYzB
         aYYSkQUYfPLuVHDs/BEPt6yhe4ngxChIiatnwkUzF/gy5ldlp8IsOn8HujcIOJ0Q4soI
         DoQ9ZIkoPE/ki/1CoMAn80Xzz18ChlgphzvhthG2Is0gKbzLcrdnrdnkU0expKFxUD1+
         CpSey6wpxdZYFR3F+Rpm4J4go39SLFA8JY/2pyGPaW10eUQbaRgJjjhz6/mttBZHyyk5
         rzF9eSaZy0/JKug4l5A3a8Or8NxpLB7ABY3E9n2Xq9uIEIJ9aFssjUrW32NfRtaIbIWb
         FmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111003; x=1775715803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiO+++X2XWJCNONNUVesJ9wp7nfMnqRsXWPIn4UAtw4=;
        b=kaWigIsuhwykY+5+m7Y3NM3tB4OzhEwyLug4KySexvn8PcicKoRC3rz3C3hhoUox0M
         1JL3CsaFhXSZ778zhEerjOgTvwtOmIpdVA8BXxxWePpwWR1HTLuNiH393J0ji6lK5GII
         1SbxHWgFH/U764g05BCsxs8jbekfxvvQaZfHxv+aD3JwZDb7tlha+ZjCNwTGhCPm0t+j
         4XBYA2aSOhboCk37cwt6uLSjLb9FZaXkG+fvQQOaL5+31l5IrX8EcLQbcAy+jrPBeJXU
         j87yADtZoQhbzmRgvKpIrpnEg2cAZT0k8lrw1G5IIE16uwOEjqkyhWgdD4GrEjVR/Rql
         q5Hw==
X-Gm-Message-State: AOJu0YyBkswmA0G2QYPNbn1Rr6d0NjuJ3igC0VbLomaGpvzIVZH0PAwV
	eJPLXcHUJOII7aTZSTDkJQAQfhrCT4SlndeGGRNAUntfemsHA0c2MGALbsOG1024Bg3rc112lPO
	Zm7mg2zYKA4JxWWBu826qks9Mdf4fEuvnmVH+x0Q=
X-Gm-Gg: ATEYQzwbhnYiL+b5nBUKme7XTU4X9TUFLsPtMJ1bcE6z1+UMPfGSeOfdodY+KiIrbci
	CqK2l+ELO5Jj8FqdW+k1wmfW7c8JoXb3ycTdPZP456vaOPuDDVq9Co9gbjQPY03G1w7Z5eP11jN
	4NGq67/6UGq2n2e9r7aksh/x4dwe2Eg35SZdXGPBN3cRXOpJJIO9sYz8A/1gfmj4cAln2Vpr4v5
	AOJzTB/YpI7ndfTFBo9A/3c/MtWOUY7CpoL27Vtis14Rl3arBYOWkBDckOOH9zWUQByFJwMC7UL
	XUpBg5E=
X-Received: by 2002:a05:7022:48e:b0:128:bae0:e043 with SMTP id
 a92af1059eb24-12be650ede3mr3028568c88.31.1775111002817; Wed, 01 Apr 2026
 23:23:22 -0700 (PDT)
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
References: <20260401194000.1-deepakpathik2005@gmail.com> <CAGSu4WN88r1+zZw8G7Y3S2oQ1MV3J9w+oWX-FeRQC=bYu8Ntdw@mail.gmail.com>
In-Reply-To: <CAGSu4WN88r1+zZw8G7Y3S2oQ1MV3J9w+oWX-FeRQC=bYu8Ntdw@mail.gmail.com>
From: Deepak Pathik <deepakpathik2005@gmail.com>
Date: Thu, 2 Apr 2026 11:53:11 +0530
X-Gm-Features: AQROBzBp_MavaJpEtW3ook0U9m_fEWQHSbuzJ4kYTzBcrI1rDXvObaOfUmusC38
Message-ID: <CAHf8aCVgzvcAg1m_xxQunCE97Ney5NvN+zjtoVtDP+DGpCcFkw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix fd leak in erofs_metamgr_init()
To: Utkal Singh <singhutkal015@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com, 
	xiang@kernel.org
Content-Type: multipart/alternative; boundary="000000000000c28969064e743c20"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3171-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B0D513846A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000c28969064e743c20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Utkal,

Thanks for the review. You're right on both points =E2=80=94 v2 will use
erofs_io_close() and fix the indentation.

Thanks, Deepak Pathik

On Thu, Apr 2, 2026 at 9:58=E2=80=AFAM Utkal Singh <singhutkal015@gmail.com=
> wrote:

> On Thu, 02 Apr 2026 01:10, Deepak Pathik wrote:
> > +if (!m2gr->bmgr) {
> > +close(m2gr->vf.fd);
>
> erofs_io_close() does more than close(fd) =E2=80=94 it dispatches through
> vf->ops->close(vf) if ops is set, and resets vf->fd to -1 afterward.
> Using raw close() here skips both, which is incorrect.
>
> Also, the if block is missing tab indentation.
>
> Suggested fix:
>
> if (!m2gr->bmgr) {
> erofs_io_close(&m2gr->vf);
> return -ENOMEM;
> }
>
> On Thu, 2 Apr 2026 at 01:10, Deepak Pathik <deepakpathik2005@gmail.com>
> wrote:
> >
> > In erofs_metamgr_init(), erofs_tmpfile() returns a file
> > descriptor stored in m2gr->vf.fd. If the subsequent
> > erofs_buffer_init() call fails, the function returns -ENOMEM
> > without closing this file descriptor.
> >
> > The caller erofs_metadata_init() handles this failure at
> > err_free, which only frees the m2gr struct. The fd is
> > therefore leaked with no remaining reference to close it.
> >
> > The success path correctly cleans up via erofs_metamgr_exit(),
> > which calls erofs_io_close(&m2gr->vf). Mirror that behaviour
> > on the error path by closing the fd before returning.
> >
> > Signed-off-by: Deepak Pathik <deepakpathik2005@gmail.com>
> > ---
> >  lib/metabox.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/metabox.c b/lib/metabox.c
> > index 12706aa..d55e787 100644
> > --- a/lib/metabox.c
> > +++ b/lib/metabox.c
> > @@ -32,8 +32,10 @@ static int erofs_metamgr_init(struct erofs_sb_info
> *sbi,
> >
> >  m2gr->vf =3D (struct erofs_vfile){ .fd =3D ret };
> >         m2gr->bmgr =3D erofs_buffer_init(sbi, 0, &m2gr->vf);
> > - if (!m2gr->bmgr)
> > +if (!m2gr->bmgr) {
> > +close(m2gr->vf.fd);
> >                 return -ENOMEM;
> > +}
> >         return 0;
> >  }
> > --
> > 2.50.1
> >
> >
> >
>

--000000000000c28969064e743c20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-font-claude-response-body gmail-break-wo=
rds gmail-whitespace-normal gmail-leading-[1.7]">Hi Utkal,</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Thanks for the review. You&#39;re right o=
n both points =E2=80=94 v2 will use
erofs_io_close() and fix the indentation.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Thanks,
Deepak Pathik</p></div><br><div class=3D"gmail_quote gmail_quote_container"=
><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 2, 2026 at 9:58=E2=80=AF=
AM Utkal Singh &lt;<a href=3D"mailto:singhutkal015@gmail.com">singhutkal015=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Thu, 02 Apr 2026 01:10, Deepak Pathik wrote:<br>
&gt; +if (!m2gr-&gt;bmgr) {<br>
&gt; +close(m2gr-&gt;vf.fd);<br>
<br>
erofs_io_close() does more than close(fd) =E2=80=94 it dispatches through<b=
r>
vf-&gt;ops-&gt;close(vf) if ops is set, and resets vf-&gt;fd to -1 afterwar=
d.<br>
Using raw close() here skips both, which is incorrect.<br>
<br>
Also, the if block is missing tab indentation.<br>
<br>
Suggested fix:<br>
<br>
if (!m2gr-&gt;bmgr) {<br>
erofs_io_close(&amp;m2gr-&gt;vf);<br>
return -ENOMEM;<br>
}<br>
<br>
On Thu, 2 Apr 2026 at 01:10, Deepak Pathik &lt;<a href=3D"mailto:deepakpath=
ik2005@gmail.com" target=3D"_blank">deepakpathik2005@gmail.com</a>&gt; wrot=
e:<br>
&gt;<br>
&gt; In erofs_metamgr_init(), erofs_tmpfile() returns a file<br>
&gt; descriptor stored in m2gr-&gt;vf.fd. If the subsequent<br>
&gt; erofs_buffer_init() call fails, the function returns -ENOMEM<br>
&gt; without closing this file descriptor.<br>
&gt;<br>
&gt; The caller erofs_metadata_init() handles this failure at<br>
&gt; err_free, which only frees the m2gr struct. The fd is<br>
&gt; therefore leaked with no remaining reference to close it.<br>
&gt;<br>
&gt; The success path correctly cleans up via erofs_metamgr_exit(),<br>
&gt; which calls erofs_io_close(&amp;m2gr-&gt;vf). Mirror that behaviour<br=
>
&gt; on the error path by closing the fd before returning.<br>
&gt;<br>
&gt; Signed-off-by: Deepak Pathik &lt;<a href=3D"mailto:deepakpathik2005@gm=
ail.com" target=3D"_blank">deepakpathik2005@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/metabox.c | 4 +++-<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/lib/metabox.c b/lib/metabox.c<br>
&gt; index 12706aa..d55e787 100644<br>
&gt; --- a/lib/metabox.c<br>
&gt; +++ b/lib/metabox.c<br>
&gt; @@ -32,8 +32,10 @@ static int erofs_metamgr_init(struct erofs_sb_info =
*sbi,<br>
&gt;<br>
&gt;=C2=A0 m2gr-&gt;vf =3D (struct erofs_vfile){ .fd =3D ret };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0m2gr-&gt;bmgr =3D erofs_buffer_init(s=
bi, 0, &amp;m2gr-&gt;vf);<br>
&gt; - if (!m2gr-&gt;bmgr)<br>
&gt; +if (!m2gr-&gt;bmgr) {<br>
&gt; +close(m2gr-&gt;vf.fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
NOMEM;<br>
&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; --<br>
&gt; 2.50.1<br>
&gt;<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000c28969064e743c20--

