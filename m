Return-Path: <linux-erofs+bounces-2795-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGWtCz88uWkowQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2795-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 12:34:23 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8022A8E55
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 12:34:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZqcC3yftz2yjN;
	Tue, 17 Mar 2026 22:34:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f30" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773747259;
	cv=pass; b=OUiVK0QmaDs/FYA9lFmD/LHxBTQ/PKH4EyJc6VwV8wZzzaK/bSzY9D5Kt7GiqWasLYO0Fkoe779t87v8LuKHbd2+W0s8tvhbfeAJvKGvY3SOsF6YdTGMIWkciP7waIAWWU6D8Ctxt4xFFCrJAi0iXCoOWc5cjSemnwh8BuFzwTnEb3mjp4dP0EzDGK4jFc35NLVRtZzRvssPKDoiB4NQzQHDFNI6PJJ0+p72ej/TRPwoRVmyl6NK0arupsra4WGoagQ3bBf4EwugD3Iva4x4ilqqvqObsiurrpL6FfP/ZiohlEnVYOU3S9Wzri5fWdoz0h+9Fy9a+kTJkNvG4rPPMg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773747259; c=relaxed/relaxed;
	bh=ZWf59g/f9dbyJaifN1LWNv4dt9SqeUiBuBEPLFTwS4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvLSnbRAyRn/J7rXUyIGNH1r0FKRqXdkdhXsQvaaHi3vvVVB5U2jmCJI95unhFRD1NbvB+7AoTC4SX9YQ9s1LydSvvH2s8DywYWGnECrefSYbGnEDKzNmWChDgCA4D6UU+GQ4k1GLQAmdaOBzhWVBOczjx3d1Mxs9oislU81eRiZLOBJ/DBPZa+fUFUtnb530HM3SFhfYKnIBQD1fqmbjA3BG41uUveR03SLWanicDUE8rInBi9Z817+qfxKOTCh4LWwWXPLqfjvtvPWUwoWr6rzi7Ta3I0p0qe1+f8uMhC2b5/CZaZIVtRl2xwCnAPVJDwDGq2etz4VfQunENnruw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Sp5b03bA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Sp5b03bA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZqcB4msYz2yj1
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 22:34:18 +1100 (AEDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-899f3cc8e4dso5287096d6.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 04:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773747256; cv=none;
        d=google.com; s=arc-20240605;
        b=bEuciEZJmWqc5QDCr5m4/wDR20w7Yyf/SIyWE7U/KnNnRyuaEPa90vuj8n1MGq/r3g
         DnwmzeENfxycFuuL2qFwryEM25/BppJhueaJ7tHueAY9OcXwwj2SlBjezX7whW2Hb3aV
         i9vPAYPWamNFSYogpJPPr7E0G6ZujqHhwIFoQ1+EwHzn+sa6xkhVWiCckr+hecjh1smq
         /0I8W+OfNqntRKmOSyRmVpStgMQcfsEaF7H42yWkIRt2ot1PtS8KzciY14XQr+Ld5PVi
         D2HC4SnIECi8Lj+gSvQz+o/BSXLL+sR8GecSkshvNlQKY8nW8W/u6A05OxpZnB8YHCzk
         Q7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZWf59g/f9dbyJaifN1LWNv4dt9SqeUiBuBEPLFTwS4k=;
        fh=MbNNyKNJAT9O2DmogO2mgwrEz96kfBdMTN4QFZAjVhk=;
        b=Sv2QIncYDT3ChjuHIlnHMo3xUgFr6a1E3JgRdPdeoAMionfNRW/OvY2+fSoZb5HqWd
         MCrj9v1vbOxp9WXZ15UdUQbmF0TkTOEfLJJxLUYYcSUYwC15r6tMu24ybMvpWvkNdgLC
         Gf53Uwdt8Tzgyp2x8vwiGxRPjqp+KrhN4cbxsOpfgW4U63slbCXA2hZlNezUP38P2mXv
         rluYMBhrYfVh0RKKNWcV1pRgi1v6gRM48knNUsptBbE+bx0ai1B8qO2t9B0nrzfJn/bU
         IqaMckyyvdXMyyUtyP4MSBR+4miyiVoW9LeqRvhc20ILeh+xudcoBa2gQ7t72gmcaAq7
         QUQg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747256; x=1774352056; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWf59g/f9dbyJaifN1LWNv4dt9SqeUiBuBEPLFTwS4k=;
        b=Sp5b03bA1p+x21sKlgF178PHVIB1ltq3q0zzvKyDR96o+fZ9lADP6Buc8dhXimp9ub
         nDNICbHKS1MnWtsaEQszmt+sLIoGusArOI+KsohJy2ledxn0E00RRKpVU9R3kRbXUcno
         zTF7DOzCwPxbVzd98dqb0ad3RZphjj2WGpq7eP1z7XmE1VOeGy/6BleMknfoJc0yzBBT
         9ZJd18t3mXuMwj4oTawYseE3CCfHg+V0uSKuJ9jBL0+WqBu5uA8C/YcQo+2mWpdEWxji
         Lx2Xg3fap3jfZ2DDyMkeTqr+y4O2fP3pPRjZcRfRu7+Xx3WJG65abGhkpD+TUlFPWTfd
         clDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747256; x=1774352056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWf59g/f9dbyJaifN1LWNv4dt9SqeUiBuBEPLFTwS4k=;
        b=Z00fsFj+ttM6PoVbIpfX2GC4Zw4gZL7Sf9qyyWEN2AIlaGiJ1+WlK4cm7YE/jPc88Q
         fbS8PIODlY0mrogfokIfBFmvaQ9UcXwglkMId0tj8554omxwRJW7/hlziK7WVJDgPtep
         HPsyhQZ2787vMZr+tCYvcD9NgTLM76XCrtxkE962WXc++/aJJhBGz4CzWSE3ekYMUwup
         yDDv67CUyH0p+lUymH4cyn6U9RNTi0VmMoImgYP+wbuxx1Bd3L2etAlAVObSSUOUnjxt
         lLoRNbmZs9KE1kW9itXlbGnAFzoBWUFBvnBeWewNaPXmkxM+oN/2pCTor6zAMkd//YrT
         zBMg==
X-Gm-Message-State: AOJu0YyRTcw/u2QoVPtrcBwtF11+3GrWK6EO2U24+6usIo0TqfqE8KbX
	jC9UWyd6pBX1Y22hn7z9aKpuwiPkJMcE2UF52/+H2isVVID6CEqlEv5Ccf0S33bnfhJjY71vj6J
	F13OJ8WtE+HsKJwiKMahNzE5n2zGAJgw=
X-Gm-Gg: ATEYQzxwLnGEbQyrbjV28H86goLNGhuaV+/TdMsOD7u8fQmDBnIoNg+MYfOj6TSqiGM
	TLIOPXDnEpcskMXmUf07wvfZjYoNqHB93rjPDusSmPwlSZjMAzQecSPnsAP6YdlyMQOZ2VMWlSn
	jAEAdSRbCNR1hhSSUuQJ+eIDSAKCW8ffDJCayQS91ESRv1ixvDaoaUMNw5Thh21czsJNawwCsfw
	yWxmw/KzMA+crarHUaJucK0aUC3VBa0ELbqXL+6shwdUIxGNiAF9T3fwOh/ar2jiLdd+QV+l8N9
	DTp9ZL3mlMYFRoqkDLvX4MnQTKUcVkrqPWXXqzDt+xL//TQZL6zlpl/zJkFgRECwpJV8jQ==
X-Received: by 2002:a05:6214:4784:b0:89a:4b00:bf42 with SMTP id
 6a1803df08f44-89a81ec1657mr159540786d6.4.1773747256344; Tue, 17 Mar 2026
 04:34:16 -0700 (PDT)
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
References: <20260317111743.84988-1-singhutkal015@gmail.com> <e8729997-91ca-4bf0-bb52-78eec7fc7f2f@linux.alibaba.com>
In-Reply-To: <e8729997-91ca-4bf0-bb52-78eec7fc7f2f@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Tue, 17 Mar 2026 17:04:08 +0530
X-Gm-Features: AaiRm508CYLt5rzCPWYi-qLhDKX5cDjCzZZuejoMwZOowlftoegSh0wz0Cm1dVQ
Message-ID: <CAGSu4WMt34AGeESUqoqaVzNEfQBNtkJAwLY+dHAsd92AB5X2Fw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: validate h_shared_count in erofs_init_inode_xattrs()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, yifan.yfzhao@gmail.com
Content-Type: multipart/alternative; boundary="00000000000022c4ae064d36b7fc"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2795-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@gmail.com,m:yifanyfzhao@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.368];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1B8022A8E55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000022c4ae064d36b7fc
Content-Type: text/plain; charset="UTF-8"

Hi Gao Xiang,

Thanks for the review. I just sent v3 which uses the multiplication form as
you suggested.

Best regards, Utkal Singh

On Tue, 17 Mar 2026 at 17:00, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>
>
> On 2026/3/17 19:17, Utkal Singh wrote:
> > erofs_init_inode_xattrs() reads h_shared_count from the on-disk xattr
> > ibody header and uses it to size a malloc and drive a loop that reads
> > shared xattr IDs.  If h_shared_count exceeds the space available
> > within xattr_isize, the loop reads past the intended ibody region
> > and the malloc is oversized.
> >
> > Validate that h_shared_count does not exceed the number of __le32
> > entries that fit after the ibody header.  Return -EFSCORRUPTED with
> > a diagnostic message on failure.
> >
> > Reproducer:
> >    mkdir testdir && echo hello > testdir/a.txt
> >    setfattr -n user.test -v val testdir/a.txt
> >    mkfs.erofs test.img testdir
> >    # corrupt h_shared_count (offset = nid*32 + inode_size + 4) to 0xFF
> >    # then: fsck.erofs --extract=/tmp/out --xattrs test_corrupted.img
> >    # Without patch: silently processes invalid shared xattr IDs
> >    # With patch: returns -EFSCORRUPTED
> >
> > Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> > ---
> >   lib/xattr.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/lib/xattr.c b/lib/xattr.c
> > index 565070a..5888602 100644
> > --- a/lib/xattr.c
> > +++ b/lib/xattr.c
> > @@ -1182,6 +1182,14 @@ static int erofs_init_inode_xattrs(struct
> erofs_inode *vi)
> >
> >       ih = it.kaddr;
> >       vi->xattr_shared_count = ih->h_shared_count;
> > +     if (vi->xattr_shared_count >
> > +         (vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) /
> > +         sizeof(__le32)) {
> > +             erofs_err("invalid h_shared_count %u in nid %llu",
> > +                       vi->xattr_shared_count, vi->nid | 0ULL);
> > +             erofs_put_metabuf(&it.buf);
> > +             return -EFSCORRUPTED;
> > +     }
>
> Again, why not `vi->xattr_shared_count * sizeof(__le32) >
>         vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)`?
>
> Thanks,
> Gao Xiang
>

--00000000000022c4ae064d36b7fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi Gao Xiang,</p>
<p>Thanks for the review. I just sent v3 which uses the multiplication form=
 as you suggested.</p>
<p>Best regards,
Utkal Singh</p></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, 17 Mar 2026 at 17:00, Gao Xian=
g &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibab=
a.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
<br>
On 2026/3/17 19:17, Utkal Singh wrote:<br>
&gt; erofs_init_inode_xattrs() reads h_shared_count from the on-disk xattr<=
br>
&gt; ibody header and uses it to size a malloc and drive a loop that reads<=
br>
&gt; shared xattr IDs.=C2=A0 If h_shared_count exceeds the space available<=
br>
&gt; within xattr_isize, the loop reads past the intended ibody region<br>
&gt; and the malloc is oversized.<br>
&gt; <br>
&gt; Validate that h_shared_count does not exceed the number of __le32<br>
&gt; entries that fit after the ibody header.=C2=A0 Return -EFSCORRUPTED wi=
th<br>
&gt; a diagnostic message on failure.<br>
&gt; <br>
&gt; Reproducer:<br>
&gt;=C2=A0 =C2=A0 mkdir testdir &amp;&amp; echo hello &gt; testdir/a.txt<br=
>
&gt;=C2=A0 =C2=A0 setfattr -n user.test -v val testdir/a.txt<br>
&gt;=C2=A0 =C2=A0 mkfs.erofs test.img testdir<br>
&gt;=C2=A0 =C2=A0 # corrupt h_shared_count (offset =3D nid*32 + inode_size =
+ 4) to 0xFF<br>
&gt;=C2=A0 =C2=A0 # then: fsck.erofs --extract=3D/tmp/out --xattrs test_cor=
rupted.img<br>
&gt;=C2=A0 =C2=A0 # Without patch: silently processes invalid shared xattr =
IDs<br>
&gt;=C2=A0 =C2=A0 # With patch: returns -EFSCORRUPTED<br>
&gt; <br>
&gt; Signed-off-by: Utkal Singh &lt;<a href=3D"mailto:singhutkal015@gmail.c=
om" target=3D"_blank">singhutkal015@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/xattr.c | 8 ++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 8 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/xattr.c b/lib/xattr.c<br>
&gt; index 565070a..5888602 100644<br>
&gt; --- a/lib/xattr.c<br>
&gt; +++ b/lib/xattr.c<br>
&gt; @@ -1182,6 +1182,14 @@ static int erofs_init_inode_xattrs(struct erofs=
_inode *vi)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ih =3D it.kaddr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;xattr_shared_count =3D ih-&gt;h_share=
d_count;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vi-&gt;xattr_shared_count &gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(vi-&gt;xattr_isize - sizeof(struct=
 erofs_xattr_ibody_header)) /<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(__le32)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;inval=
id h_shared_count %u in nid %llu&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0vi-&gt;xattr_shared_count, vi-&gt;nid | 0ULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_put_metabuf(&am=
p;it.buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFSCORRUPTED;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
Again, why not `vi-&gt;xattr_shared_count * sizeof(__le32) &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vi-&gt;xattr_isize - sizeof(struct erofs_xattr_=
ibody_header)`?<br>
<br>
Thanks,<br>
Gao Xiang<br>
</blockquote></div>

--00000000000022c4ae064d36b7fc--

