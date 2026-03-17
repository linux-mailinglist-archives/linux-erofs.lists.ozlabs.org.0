Return-Path: <linux-erofs+bounces-2791-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOloJ3AmuWm1sQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2791-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 11:01:20 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FBC2A76B7
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 11:01:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZnXm1jgCz2yj1;
	Tue, 17 Mar 2026 21:01:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f36" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773741672;
	cv=pass; b=QOwXEPKE83sMtZ5CRvOcvnjyJp++fcOmC31QklwPViSqrcUIORNVCF5CUttVT0dH3aaZrzhlIbWGttqJFECbZZUh1KGAtoEmv7GRT1GtM0Mx4iPgj64PSsEErckCQ7eQqbjM4SMQw6s3EuzSD/RbH4pNv4IB0/s+9WyJbxlxtdT4w7DiFu2uFyKJJHXgAG7PLgc+Y4+bQZxNU1G9KrWihc+gcUnQkmISR3RRHjsMQO2zXKLbeMJpR4wMcf3d8+imbh7+4VIAmf57JSbTXcP3ZdsGvNxSHGXPBdHH1L/0RxbwP0dva6uSeGAosHsDFuMC+kzmx26lMGV7motfltVjtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773741672; c=relaxed/relaxed;
	bh=IJU4yYYHyfTltjsyC4a//HUAw32Zk72ZHmzohGr99DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSRr+Cl8OszrI9QpOWanLUSZz2TPFzSEmSBhPtT2qcDRa0iB0reVGWaqNLG9oWU+tbdKkoFO4VhI0S4rxXQZsqAEtgfNYUtnjZAB0z/iRgSbdZVFBTIjkGwXbVvlHDvg2Y2FYgJMthQYjurpJ/pT+U6I68W2MjSoqq37q4XZXoCMnlKShtmIt8xa/uMuwjYq881mga3M5x3uXXIk/5tnpfHiGpg2Uxn03pOgZ9IvVzvBscIeKZxuMTBZZyNnHQDCldeGTkveZvf97R0rX8zwdElYcblSotWqtJQL4Q+T5gSNodL0ObL0omY1GYZYenOfeS000O9gIYQ5zHGXwr9XWg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JJKLeBw7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JJKLeBw7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZnXl1wm1z2yfP
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 21:01:10 +1100 (AEDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-89c662ccb4eso220776d6.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 03:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773741668; cv=none;
        d=google.com; s=arc-20240605;
        b=DBkJ/Ug861oYgdVECZfyxQp440EG47OvbA2rxUhAhSgyh6LxrA+jtCdYiPwTdPz4Qv
         iINeYXspTM1v3Ub8tqR4na8rKIec6Q/+7/E8sH/75/hDOqFAwF8fEI6zr1xnZxGMlNzV
         MSLpnF/pjLZhka3e+vRN1yl067gb3Qna1b4zpDEkJUkK75U6lRucNreza4JkXpmu9quK
         l/mZQ7oja84qx9NSuNxtW+sPC+jkDwjolo1NXGmRhnJEgW0YGo41JzOh/LKWllk+fDdR
         RQMbe9o3tlnlVmGHmvxSerib5pGsPbyeds9OoKcs2qd4scXVcyvukcmNciI8t6+bD2kI
         wPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IJU4yYYHyfTltjsyC4a//HUAw32Zk72ZHmzohGr99DI=;
        fh=Ti2Ztps5ncTGufxtmxrJu908O7DsJpNW+u8nwQfRTHs=;
        b=DE06iXFeGpx32spszYmyLqNmwTnFuzJHujt9cA6vwQO2L5Yca9qfNChhrzp2cfFdgv
         bjD9GRpXfHnYgNMOY5zHaK+3FwZ58K5M39ZuBbz4+BSoq+nSzNDMXlpUwif/Eftr+u/A
         UP3GE9Roc/7ucuEL68ep4ZXswnkGYcJCUYH8eZGipZCvJfQ3zCJPw0bJqnR0OW5QX9uL
         EyscoJ2ujJF2//8iO160XWjB9VBM8RvBBDmKSBkVASTVpxi6As8kmIxz0e8VQamGQXLc
         W4vX1Mkl+ImMUyQKSH8ElNPOcE6JHrtwbz7wKo81usiWUlRU2Ffn2XW4UsZis8gRR6p7
         x2+g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773741668; x=1774346468; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IJU4yYYHyfTltjsyC4a//HUAw32Zk72ZHmzohGr99DI=;
        b=JJKLeBw7psFlgLy0wZHXJFc2aH7MF51v8CFrb3bOZ58jSOYf4cMgxfXORD+gI/y8A5
         Ti0D78zWjm5I+q8zy+mk2GXT1dMJFHKWfNdLCyB5BLzteLgNHU9zoOZlJT6AardWAYYX
         vO6s6Dpenu01k9bzo9/PDqafMvgDkpyHJl64BuoBuHLRPqeaCboygNhpZyHfsQpuofnX
         ZQxTDahMw0G3fwewaW/2EtV98fkQ9sklMu8WHtoAUMPNoB41BMb/JNJX/3FEoPeKcuEa
         nSi7nm/dq3NOMxp9RnsPuTMXjSM8F8ylTpSXz4Pe0p+Y7/LY1oyvK55KkRJN4YG3e/gr
         7tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773741668; x=1774346468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJU4yYYHyfTltjsyC4a//HUAw32Zk72ZHmzohGr99DI=;
        b=OCqsPGJx3zbqFj0q3R1MXB2cUUE8y6BmxXKbYgvpsoD+mpFpdlV5dF0Lj15sW8bltK
         dkNXSB0ErSKYI6nt9Fnrz5+EZKOoKzzL95qJrpAciSCK6X/HOjBGRIx61ZU5FbKUtt3w
         +I8I5DhOEcyFO9ikhI1wPEFqOs0GNIBxILOnikL9yS8KDN8e7PL/V2Deuuzt8xI3Wcvi
         TPsN3qxZfnFhirZt6E0MoMBhSWKahJM3l1PvW1PnlRVfr/Hkm4TLp+1Ihv2/fqKN0UP/
         jbmlb6Hbg2wqctE2/gi4xOvKcrKR2ZLCI8S1FGdArwx/m1WOngo4lQHI9DAYp6PvFQLd
         GiaA==
X-Gm-Message-State: AOJu0YwgUT1UKzv3mMWuWWSmZLGiIG8IM6noxjNpQCpwnFmjvH+BzCGE
	yTLmFcyjv5h2f/vndBWiogrE50DaEqUSAg886g0ygT9IL8iIQd2DadetLQPlMuKwKulOlgxZOtW
	vURTH1MkM/3uUhZv5Yi+GBi5pfHEdNyfv3GC9AyI=
X-Gm-Gg: ATEYQzwDyfIwIP9tt8KzcnWGlrCI1WSlKzQMgmPLz/KY0/BtiZ75LRCzLZ+a2hxSCth
	TXtncza+6ycnErUtXW2YOaUZhTX1hrqBGg9zqPO7zHA3n7GiFZ0Z/kkHrbEwO0HrY7//ieWNJPE
	d489eZd0Dk7f8rQT2c2Rt4biJs4Y9ua7VQZLabfqwB0X24IYeFVxKdXvtO7FYUJz2ShUF8lRgA8
	Xj+cBuubcRreZOZxYUcyWSCWxUIdVS4z98MEPaElyJvoewtopXP96cwxiFBOqoipDHWWi1ZDzxF
	yGBEnN2k7J8XtIJy19+ASahCGTFLYJvD/L901TLGdDznx68Rtg167RjiXd2np55atPWWwDZ8vMz
	yEdE=
X-Received: by 2002:a05:6214:4784:b0:89a:4b00:bf42 with SMTP id
 6a1803df08f44-89a81ec1657mr157000176d6.4.1773741667449; Tue, 17 Mar 2026
 03:01:07 -0700 (PDT)
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
References: <20260317045537.9591-1-singhutkal015@gmail.com>
 <20260317045537.9591-2-singhutkal015@gmail.com> <a65ab6cb-3e98-433c-921c-fd0b7cc8c188@linux.alibaba.com>
In-Reply-To: <a65ab6cb-3e98-433c-921c-fd0b7cc8c188@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Tue, 17 Mar 2026 15:30:59 +0530
X-Gm-Features: AaiRm50FlE-lFpcSD1Dhfmsd9GreY1jYJJDK1xxm8VUP4gLcRIutMlAv1ngZ3kc
Message-ID: <CAGSu4WPN1pYbR9UnwuYGGqGt+n-Paz+84wxFs+kdFxetyB9tYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] erofs-utils: lib: validate ZSTD frame content size
 in decompression
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, yifan.yfzhao@foxmail.com
Content-Type: multipart/alternative; boundary="00000000000002fe57064d356aae"
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2791-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,foxmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.969];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RSPAMD_EMAILBL_FAIL(0.00)[hsiangkao.linux.alibaba.com:query timed out];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 02FBC2A76B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000002fe57064d356aae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the direction, Gao Xiang.

Understood =E2=80=94 switching to ZSTD streaming APIs (ZSTD_decompressStrea=
m)
would eliminate the ZSTD_getFrameContentSize() /
ZSTD_getDecompressedSize() dependency entirely and align
erofs-utils with the kernel implementation.

I'll work on a v3 using the streaming approach.

- Utkal

On Tue, 17 Mar 2026 at 15:23, Gao Xiang <hsiangkao@linux.alibaba.com> wrote=
:

>
>
> On 2026/3/17 12:55, Utkal Singh wrote:
> > ZSTD_getFrameContentSize() reads the content size from the ZSTD
> > frame header in the compressed data. This is untrusted on-disk
> > metadata, independent from the extent map that provides
> > rq->decodedlength via z_erofs_map_blocks_iter().
> >
> > A crafted EROFS image can set the extent map to claim a decoded
> > length larger than the actual ZSTD frame content size. When this
> > happens, a buffer of the (smaller) frame content size is allocated
> > and decompressed into, but the subsequent memcpy copies
> > rq->decodedlength bytes from it -- a potential out-of-bounds read.
> >
> > Additionally, the ZSTD_getDecompressedSize() legacy fallback
> > returns 0 for frames without a content size field. This leads to
> > malloc(0) followed by out-of-bounds access on the returned pointer.
> >
> > Reject frames where the reported content size is zero or smaller
> > than the expected decoded length.
> >
> > Reproducer:
> >    mkdir testdir
> >    python3 -c "open('testdir/f','wb').write(b'A'*131072)"
> >    mkfs.erofs -zzstd test.erofs testdir/
> >    python3 -c "d=3Dbytearray(open('test.erofs','rb').read());\
> >      p=3Dd.find(b'\x28\xb5\x2f\xfd');d[p+4]=3D0x20;d[p+5]=3D0x01;\
> >      open('test.erofs','wb').write(d)"
> >    fsck.erofs --extract=3Dout test.erofs
> >    # Expected: ZSTD frame content size 1 < decoded length 131072
> >
> > Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> > ---
> >   lib/decompress.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/lib/decompress.c b/lib/decompress.c
> > index 3e7a173..fb81039 100644
> > --- a/lib/decompress.c
> > +++ b/lib/decompress.c
> > @@ -48,7 +48,14 @@ static int z_erofs_decompress_zstd(struct
> z_erofs_decompress_req *rq)
> >   #else
> >       total =3D ZSTD_getDecompressedSize(src + inputmargin,
> >                                        rq->inputsize - inputmargin);
> > +     if (!total)
> > +             return -EFSCORRUPTED;
>
> hmm, that is the difference between the kernel and erofs-utils
> implementation.
>
> the kernel uses zstd streaming APIs, so it won't malloc()
> a new buffer in advance, actually I think erofs-utils should
> switch to streaming APIs too, in order to avoid
>
> ZSTD_getFrameContentSize() and ZSTD_getDecompressedSize()
>
> dependencies as you said in the commit message.
>
> Thanks,
> Gao Xiang
>
>

--00000000000002fe57064d356aae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the direction, Gao Xiang.<br><br>Understood =E2=
=80=94 switching to ZSTD streaming APIs (ZSTD_decompressStream) <br>would e=
liminate the ZSTD_getFrameContentSize() / <br>ZSTD_getDecompressedSize() de=
pendency entirely and align <br>erofs-utils with the kernel implementation.=
<br><br>I&#39;ll work on a v3 using the streaming approach.<br><br>- Utkal<=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, 17 Mar 2026 at 15:23, Gao Xiang &lt;<a href=3D=
"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2026/3/17 12:55, Utkal Singh wrote:<br>
&gt; ZSTD_getFrameContentSize() reads the content size from the ZSTD<br>
&gt; frame header in the compressed data. This is untrusted on-disk<br>
&gt; metadata, independent from the extent map that provides<br>
&gt; rq-&gt;decodedlength via z_erofs_map_blocks_iter().<br>
&gt; <br>
&gt; A crafted EROFS image can set the extent map to claim a decoded<br>
&gt; length larger than the actual ZSTD frame content size. When this<br>
&gt; happens, a buffer of the (smaller) frame content size is allocated<br>
&gt; and decompressed into, but the subsequent memcpy copies<br>
&gt; rq-&gt;decodedlength bytes from it -- a potential out-of-bounds read.<=
br>
&gt; <br>
&gt; Additionally, the ZSTD_getDecompressedSize() legacy fallback<br>
&gt; returns 0 for frames without a content size field. This leads to<br>
&gt; malloc(0) followed by out-of-bounds access on the returned pointer.<br=
>
&gt; <br>
&gt; Reject frames where the reported content size is zero or smaller<br>
&gt; than the expected decoded length.<br>
&gt; <br>
&gt; Reproducer:<br>
&gt;=C2=A0 =C2=A0 mkdir testdir<br>
&gt;=C2=A0 =C2=A0 python3 -c &quot;open(&#39;testdir/f&#39;,&#39;wb&#39;).w=
rite(b&#39;A&#39;*131072)&quot;<br>
&gt;=C2=A0 =C2=A0 mkfs.erofs -zzstd test.erofs testdir/<br>
&gt;=C2=A0 =C2=A0 python3 -c &quot;d=3Dbytearray(open(&#39;test.erofs&#39;,=
&#39;rb&#39;).read());\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 p=3Dd.find(b&#39;\x28\xb5\x2f\xfd&#39;);d[p+4]=3D0=
x20;d[p+5]=3D0x01;\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 open(&#39;test.erofs&#39;,&#39;wb&#39;).write(d)&q=
uot;<br>
&gt;=C2=A0 =C2=A0 fsck.erofs --extract=3Dout test.erofs<br>
&gt;=C2=A0 =C2=A0 # Expected: ZSTD frame content size 1 &lt; decoded length=
 131072<br>
&gt; <br>
&gt; Signed-off-by: Utkal Singh &lt;<a href=3D"mailto:singhutkal015@gmail.c=
om" target=3D"_blank">singhutkal015@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/decompress.c | 7 +++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 7 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/decompress.c b/lib/decompress.c<br>
&gt; index 3e7a173..fb81039 100644<br>
&gt; --- a/lib/decompress.c<br>
&gt; +++ b/lib/decompress.c<br>
&gt; @@ -48,7 +48,14 @@ static int z_erofs_decompress_zstd(struct z_erofs_d=
ecompress_req *rq)<br>
&gt;=C2=A0 =C2=A0#else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0total =3D ZSTD_getDecompressedSize(src + inp=
utmargin,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rq-&g=
t;inputsize - inputmargin);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!total)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFSCORRUPTED;=
<br>
<br>
hmm, that is the difference between the kernel and erofs-utils<br>
implementation.<br>
<br>
the kernel uses zstd streaming APIs, so it won&#39;t malloc()<br>
a new buffer in advance, actually I think erofs-utils should<br>
switch to streaming APIs too, in order to avoid<br>
<br>
ZSTD_getFrameContentSize() and ZSTD_getDecompressedSize()<br>
<br>
dependencies as you said in the commit message.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
</blockquote></div>

--00000000000002fe57064d356aae--

