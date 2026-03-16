Return-Path: <linux-erofs+bounces-2735-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNJmGZq9t2mpUgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2735-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:21:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF4929616D
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:21:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ7NR2Ph8z2xpn;
	Mon, 16 Mar 2026 19:21:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f32" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773649303;
	cv=pass; b=CIYgamLCjWMR2ugoTB36UDLu4coPrkfXkmRK/JcBwn/vjLkHfmTwKr0K4IYqkhx0HV09p8JaFRGNRg15MxXQGCtexsyAEoEpwL0cydSO/kImLUi3wSRuq0Z4IejokqoRVZb7IRm7dSSH4MbVUgixfe26eHqvj98EtH0D2e+YYsgiJ3IMkBgzFEZORo+H48rJ987vJomSCkYofp0T00kbIfOvKoAsEGNiS6cbabDZBIfD5D6ob44JO9wuF74T9rDD2OCv2LEHX0jqEwSnV+VJMU7RD8BIqrWYT9fiXt35OuIFvORTmbZZKQDh4+DZ6pHcPPK/0SqznE/wfyZ/SYxd4A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773649303; c=relaxed/relaxed;
	bh=dOdS2QO1n8B+B0t0asxZwyrMSCd3M10rmjhEwpDvKnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmhCVxlU7Ah9v+EaVoK8EXxsnQGN69zHFMIMa9KhKKibYIwCfRB8e58py/TK+xH7bRLgy637AcBIO1HBetmJWqAGFFclj788iLr3QjtjEpT/SzClw/tz8rdlf3zP/62fBNflLOxkpFR33KYoxNk1GIIWQpefcxKvLjPeCU4aIMqT9VNUOKnr3Ie482/d3junS05dg0RSfBxf55Px8P7Hfiy350dwQ5aEEEudSjw8axeiXnygMnUtqdK1kxUapcR30DPcfxHs3xtt68pOBTOJ57BAqbjQRpQ8C2RIEZG0G84ZGIQ1zyk8rM15j71NT7RCb6weSdNreVfsFCVCbTAu1w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Bu1fiPBY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Bu1fiPBY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ7NQ3rT3z2xln
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 19:21:42 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-899f50ab3f2so8414656d6.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773649300; cv=none;
        d=google.com; s=arc-20240605;
        b=gn/I1ZaV+sWu3hCaD5ruD5vLZsPgauAWpbNYCft0nThnMMUNHr+p7UAQtl24Qv7j6w
         CbG9UPPx2g95u96PHZZOl6ToKhaQBrFj0w20sVWm0ZvOVka8Ful9P+uJFMcdJoAB8VG4
         G4nj9sUqZHHs417SrBvrhlP1myU3GoL5CLWXTFjlDB5JKUx6dpTD84sHHLykoi7WmyIW
         RCjiLQCn7rNsUUDEJh11M3o2llpXFVTvE1rDN30G50UsPqf73ilZ5eIjnqLP2QGibPC6
         lxIMTXHZELjLl+x1vOgIBAVmrX8ZWxMo4oHVKF2V0h6gxIv9OlPKsaO4nEmASdCrXnLs
         Bg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dOdS2QO1n8B+B0t0asxZwyrMSCd3M10rmjhEwpDvKnM=;
        fh=+B5NJMHgZVlSETmvknNIc/yWRJuXFX3qfkrcJIg5vdE=;
        b=RYXIyM9Bo146HU5Z/H6Rpqu6b+J1TjCDUsnsjfMqE6O5uU/odw5mdM2xVs4WBcn95K
         TfXhFQMVy+LsoDL9Gu+3rZE97+mZgeLqowB8BlnRFqkteRC6Dpvzg7oGJQZyiIWYFYuD
         KOlGhm0++MVSiPNBO5hFrXM15aHdB/sbaGsObxrWdfQR7z5oQPWnbMaRHBSv29zyU1qF
         YxEW+lFx7SfpbodDuE6TQOIHLXkYuZY3RshqZZgkSAYoGkCrX+jUDj8OwdN/C/xIgEFo
         q6T70ZuYxBCGpxf9JvBX63j04CULUcJiYGOMWiiNpSfFJflZiR/w5XQCpstNaB7Kfj17
         5XAQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773649300; x=1774254100; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dOdS2QO1n8B+B0t0asxZwyrMSCd3M10rmjhEwpDvKnM=;
        b=Bu1fiPBYHWBwJpHT9gmFUlPVBALtH3Lj8Z3sIQwr+BBZGuXZjXSqU5LYlAOhJctSVU
         MzluNYbnZ0lY/OYJMmXHV6cD1PBE3cXX3Odrv9yh8wNCareC6BbWof0ToEjX3mYB2X1h
         kJ1eL9KEN+cnuRIewCsxix4BmHKNOHiHAr1XOXnEMw+eg77RpgazHNDOQ64dKNZxNWAe
         fV/US3iyEjgqOR6tEMNu84LdaFDqAtoMpoY0IIA75jgteH7+0xJN1lLD668kBy7K3j2j
         d3D7Ndu+EQmbRDP83a7Hp1TouGUkAisES/T85mIbSrVHMKzxEd/3eSmLQZ+zErlaEbCw
         38Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773649300; x=1774254100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOdS2QO1n8B+B0t0asxZwyrMSCd3M10rmjhEwpDvKnM=;
        b=hXdrHD4UaREHQlRFDSGipyrO1oLSuXDokiYeM9ALwiZEtbIXf75WYKrbHeJmQufLwC
         ylNBJtTK5N2xrZLPFUhPuRxHM9/CkhLisT4K1jiEOCRPH82ymay9OaTzVMjD9x4wuGMW
         iVV8iFXf77al5lAAXC4KEcVRJAmrSQnEwHjj+Cq17wTaoibFygWcY7zFDtsUiS+vE/sx
         BgXCgeLlHO2HXeqL2RP3K4vhwkJRaKmvcku45vnkxc68t11PuBoNAJ0k5t42ph0nT4MQ
         mhOhntfOqIYWO+CihBK6+e63O7MeFLJ/xWNih+XuB0sDslCMJoXksqEEbioogmbpHwJn
         hb3w==
X-Gm-Message-State: AOJu0YzEwQt4MuZ7n+zMuZRzOYMBhHC4ZZmTt4E7Vzp7ZFlDx/EBi5Lr
	4cqwJHuwLT4Qu4zsX6BRPesfvnLK1Kuzt5EzaccEZPLZTVNlsXUCDaz1RiFTYRnL0y3oRIpHtEK
	ikrG61J8Zc1TtfwdSw6bO/oXopIYxOvw=
X-Gm-Gg: ATEYQzwL6pkf4WHtUIUAir+Q7XUTpsnDv0lZ/uRMBmDRdf1kFJSfLQIWMJFG5arl58k
	vqyXyxHMJ0+xBuebWABLoqfjtSRsGcY/C9zqJYE/DB3a+IAk3A2vIICbo/HetrYUQBWojDOcUUA
	utb+GaZkvN4g769DxJaNKljs/IPyRDCrJqvAFWxAIuted5hp8qv4A6/+P8HnOrNf1ObvhciVgRP
	yySmiuCMc+5jtXx+ogwkFFpMEKUN8Tc4B6aQRd/pBBebGezOBCWaKaAu+lONVg2g2oGVm4S3NhX
	u5ZsTiPEq+Kamh0G6tXaLEiZvGM1em2ohCWSZr1jjyxWqkLT5LXECrIM2OS19+GggnK4j+NSDJU
	zLvj7
X-Received: by 2002:a05:6214:4e01:b0:89a:595c:b805 with SMTP id
 6a1803df08f44-89a820986afmr123153016d6.6.1773649300372; Mon, 16 Mar 2026
 01:21:40 -0700 (PDT)
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
References: <20260316075831.35495-1-singhutkal015@gmail.com>
 <20260316075831.35495-2-singhutkal015@gmail.com> <48a20201-eec8-4457-91cd-f80634a2267f@linux.alibaba.com>
In-Reply-To: <48a20201-eec8-4457-91cd-f80634a2267f@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Mon, 16 Mar 2026 13:51:33 +0530
X-Gm-Features: AaiRm52TckMcxCmODlX9X3oyi7HsHWTUky8ROVvvygy-LNEE8Q4tLKcvV19iLFU
Message-ID: <CAGSu4WNuaheJNkJ0dyk7+6OB0kVnuHGNXVyBqXUUPUvxpwifzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] erofs-utils: lib/tar: skip PAX entries with empty path
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, yifan.yfzhao@foxmail.com
Content-Type: multipart/alternative; boundary="000000000000813e3a064d1fe884"
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2735-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,foxmail.com];
	RCPT_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 9BF4929616D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000813e3a064d1fe884
Content-Type: text/plain; charset="UTF-8"

On 2026/3/16, Gao Xiang wrote:
> I don't see a reproducible way here.

Here is a compressed reproducer for the empty path= issue:

Reproducible image (base64-encoded gzipped blob):
H4sIAIa8t2kC/9PTD0is8EhNTEktKtYvSS0uYaA+MAACMxMTMA0E6LSBgaEhgg0WNzcHCilUMIwC
WgNDA4WCxJIMW67RoBgFo2AUjIIRBQDO+4lFAAgAAA==

Thanks,
Utkal Singh

On Mon, 16 Mar 2026 at 13:34, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>
>
> On 2026/3/16 15:58, Utkal Singh wrote:
> > When a PAX extended header contains 'path=' with an empty value,
> > the computed length becomes zero. The subsequent trailing-slash
> > removal loop accesses eh->path[j - 1] where j is zero, resulting
> > in an out-of-bounds read and undefined behavior.
> >
> > Skip such entries to avoid unsafe pointer arithmetic and invalid
> > filename handling.
>
> I don't see a reproduciable way here.
>
> >
> > Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> > ---
> >   lib/tar.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/tar.c b/lib/tar.c
> > index 26461f8..be86984 100644
> > --- a/lib/tar.c
> > +++ b/lib/tar.c
> > @@ -510,6 +510,8 @@ int tarerofs_parse_pax_header(struct erofs_iostream
> *ios,
> >
> >                       if (!strncmp(kv, "path=", sizeof("path=") - 1)) {
> >                               int j = p - 1 - value;
> > +                             if (!j)
> > +                                     continue;
> >                               free(eh->path);
> >                               eh->path = strdup(value);
> >                               while (eh->path[j - 1] == '/')
>
>

--000000000000813e3a064d1fe884
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 2026/3/16, Gao Xiang wrote:<br>&gt; I don&#39;t see a r=
eproducible way here.<br><br>Here is a compressed reproducer for the empty =
path=3D issue:<br><br>Reproducible image (base64-encoded gzipped blob):<br>=
H4sIAIa8t2kC/9PTD0is8EhNTEktKtYvSS0uYaA+MAACMxMTMA0E6LSBgaEhgg0WNzcHCilUMIw=
C<br>WgNDA4WCxJIMW67RoBgFo2AUjIIRBQDO+4lFAAgAAA=3D=3D<br><br>Thanks,<br>Utk=
al Singh</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, 16 Mar 2026 at 13:34, Gao Xiang &lt;<=
a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibaba.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><b=
r>
<br>
On 2026/3/16 15:58, Utkal Singh wrote:<br>
&gt; When a PAX extended header contains &#39;path=3D&#39; with an empty va=
lue,<br>
&gt; the computed length becomes zero. The subsequent trailing-slash<br>
&gt; removal loop accesses eh-&gt;path[j - 1] where j is zero, resulting<br=
>
&gt; in an out-of-bounds read and undefined behavior.<br>
&gt; <br>
&gt; Skip such entries to avoid unsafe pointer arithmetic and invalid<br>
&gt; filename handling.<br>
<br>
I don&#39;t see a reproduciable way here.<br>
<br>
&gt; <br>
&gt; Signed-off-by: Utkal Singh &lt;<a href=3D"mailto:singhutkal015@gmail.c=
om" target=3D"_blank">singhutkal015@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/tar.c | 2 ++<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/tar.c b/lib/tar.c<br>
&gt; index 26461f8..be86984 100644<br>
&gt; --- a/lib/tar.c<br>
&gt; +++ b/lib/tar.c<br>
&gt; @@ -510,6 +510,8 @@ int tarerofs_parse_pax_header(struct erofs_iostrea=
m *ios,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!strncmp(kv, &quot;path=3D&quot;, sizeof(&quot;path=3D&quo=
t;) - 1)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int j =3D p - 1 - value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!j)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(eh-&gt;path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eh-&gt;path =3D strdup(value);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (eh-&gt;path[j - 1] =3D=3D &=
#39;/&#39;)<br>
<br>
</blockquote></div>

--000000000000813e3a064d1fe884--

