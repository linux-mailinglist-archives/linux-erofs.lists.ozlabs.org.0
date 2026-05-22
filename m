Return-Path: <linux-erofs+bounces-3478-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NWVC3RIEGrzVgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3478-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 22 May 2026 14:13:40 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA095B3A9B
	for <lists+linux-erofs@lfdr.de>; Fri, 22 May 2026 14:13:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMPDt6F8yz2yS0;
	Fri, 22 May 2026 22:08:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::c31" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779451694;
	cv=pass; b=hZHfs9prdtFka9ZgshjthT0/3YIhxAsub7KSIbt6wsRw61GZcjeAGFR6yqUZriLI/2NnljuKd0y4m5UeydXW8r5WAekBK00T4+PVr0pUA5b/7eGmxmKHvMbUGRMHJoJe5EOLwUmzvsnoORgoUKwdUVx4VJ+S0BmeVmbpRG4Sm3S66rqrPWAtvUdUgEBI8c6yugXwvhGE62ii+TESKUWYEhBIdEKMnXDTyJlmDYTDGhRKjIRfkSu+S+i4ZxHWkATCg3JBlIb0Wuw6Bwi0qZvj9zDT58l9bkPzEqazB/ayz6XgGn65D4yYEtNOW2Sk8RU8cqfFTeLTGd6F27rt0BYPwA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779451694; c=relaxed/relaxed;
	bh=WPPiO+IjtqoQMDDwtE3EqMW+K5RAzIAiZQwvoMS/2Es=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncqt96SZjzuoCFBrFpkw+DjyFbgdtyzSv+wWQMPuFdiMLUHh1l/s5LV6m8F5pWQSxsEK4wMvXxokDaBzzGTtexDmIJU/k5/qEQhdZVfBUuPDprenGwQGgB1VBfDJY+0fv4C+TcFtqznSOqZQzpbI/M9it2qD2ZfUTr3arWPKIyqh+nTO1mHNWkc9b6EPwL3uFxy8j8RnSW3hVcnhqSjabOQI+J7/U8veTiTJwPrW7kMKcrwm7djA/l9UpojIkmvtV8fy+BDiOpVFGsl13rfxVmsD1rlLIyLzOjlFnGjUx9xV7hjIVz/6gMZaA5/tSQOL6GTXl6OjUSvWOHWtd8l1Ww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D5Z9CL8v; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D5Z9CL8v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMPDn2yHjz2yHT
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 May 2026 22:08:08 +1000 (AEST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-6948da50eb5so3832319eaf.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 22 May 2026 05:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779451687; cv=none;
        d=google.com; s=arc-20240605;
        b=TwQahD09Q0Qmud/wjxyUe4CEqx2joIfexlsOZSz94ue8z2uUWFie5K2R8xLYdP+6A1
         EFLXrFkOvckQpi6iLaUBgvprop6Ub2xkSYAM5mP+cLIXBSaHdNLx6hrpMPaTi6OIxCxZ
         wBjZEtutSwBDpuCoUQWUvUZuJAXbTwk4ZuEtb1G+fwwYAwDVMZDMgQJi2KNoIPL8NDjM
         flcqY+M0dHB8mB/3lumPSvxyx0l5pOrQT1gnKJOi4iF11R9wDHIx/qhjyp6zDTpjGNKK
         etcuzMz5MD8iscGm2XRetksKef0wxjCnonbn142Y9f0meNpve/StvpJytIU59qkCOqL+
         yWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=WPPiO+IjtqoQMDDwtE3EqMW+K5RAzIAiZQwvoMS/2Es=;
        fh=zOMGW1PlR8qSnW7bpAvrI1GrCAYf7uIKYve31giD0XY=;
        b=HkFNNHNvyNcqj46qli8Z7Jn568+Wq3JQkqSXj7dEwG6XzoCxJZzl4LgEP7Me/H7MJS
         6Gk2DjGbCXXwmgali66R5S1/KvPKDwZ/xTJ0OyVaV/h9+8LHwe9OM1QphQ2X9ct6GqEU
         isfPqarhY/MX5Qiz0ZjipRtusc0nXrnCmy35THDV9kXLigSE11G/4vhR+p00ULsrncGu
         zdt3efoYCBacd8MsqjE59jAFTd+L/gDMC4ns+S3sAkHZpeDL+KUiSE6R+d8WfyJs1A2j
         pyE+XhKth9rqOEL9IKNkm2b+L8VGwFWlYmC55t0kdwnUh5f7zrcNBcBfQk/9kDTAaBo7
         Fciw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779451687; x=1780056487; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPPiO+IjtqoQMDDwtE3EqMW+K5RAzIAiZQwvoMS/2Es=;
        b=D5Z9CL8vL2ZYjRpyNFmgxE3xRogXfBLQXsV+k+BupEAfdqJRQcWEtwiKql5+sixxxw
         N0FvC7ws7XIGjGJvI82++TJLG+okFi//rObZo4Cv8JDPsLp5/RGcTlwjYVcsaWfDSRCz
         7yeizD0XXUJIxAcWRPDcnrF8kwymg4ld4d0i7iTe6ThTYrbHHKmYhvHsLkBImHaWL6Be
         vcTA6qNfbYhDeqL0lLuSGi74H6Cl+wxTw2Qwp6VHXopfdW3B121tXMFvLX+079y+wWFE
         nvyw8k84IjAc5LS0YL4oigZAbJS7xVQkW1kn4jmlo7J/5fJ8FKFqntEr4OgQBA5oi5lB
         /d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779451687; x=1780056487;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPPiO+IjtqoQMDDwtE3EqMW+K5RAzIAiZQwvoMS/2Es=;
        b=LhQg8zYjwc5R/STn5gb3h78lPJiXlVkuztUJzK4OMBPCnXWgr7gMYn1niUoYioCwLC
         G32x+BzfnwJO0jEVLdmos4EDqE4qWPb4yOwn1jmm+FXKNJO0h9oGboSkxWSLC/2FHA6E
         AI4eQbS4fyGO4GTsMTNKYBVnnEk95GTIXX+/9te01sJOxZTXZkcDuIUBzgwjZdfTUTt5
         dBGufegdhEKKON3/kCzfKZkfEEOjGtgGlf3AiHrg5UZmPA4HKmTZR57uKMqMLBVxYZg3
         AxD1EGQRAV9wX15J6qdz/qJhDih76Wzz++TLTC/A3FLLXJJYRYLIVQYsH77/a/dPlF9q
         IKhg==
X-Gm-Message-State: AOJu0Yy6R7Xu4/uMheTNqOf+MsTk/64ZyS5bjbmPRY+kLWJ/dO0jWE9Z
	lHmEFrT/LgDX0Pys0OHYRXi0+cchDU3pVYU6hXDQ9SnUFtfhahDRwRca8/+Ay+avuXx3imtD9hj
	6G5jkYv2fTXe2ZbCcUQSsJs6H4wdg0yw=
X-Gm-Gg: Acq92OF680dHhdA+w0y+6KEAhbKynSgYs1Hb5b302hd1L8fSnTgBQuidz4O8HVL9tkc
	3hvGtA8gJr1HAEpSpsRx2EiOiVF6OKIHNsA2N3v0Bgv9VRhDGil9CCXnJyzNRcsju7xn6Rlj4gf
	MWEd3kxdp4ZwJTF7+rbgYlbdTAEFOcu7qZzYVAZj1S2dWwNEoUwmt6LZb8Z/aZnom3IRwkfj8kr
	EaniKWDbT/bg4CvuPorRC2DZy3fshITJFPWNKC6xc/VU9a2S4ERr2hYTBD1I5LkNpRy2+JTrEMn
	zKK0h1ghkSLvE3m0qMolG1FLYOmr2/vy06f7jDjv
X-Received: by 2002:a4a:e903:0:b0:694:9e2f:cfac with SMTP id
 006d021491bc7-69d7fcb51b6mr1269259eaf.9.1779451686717; Fri, 22 May 2026
 05:08:06 -0700 (PDT)
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
Received: by 2002:a05:6358:e491:b0:295:705f:db9e with HTTP; Fri, 22 May 2026
 05:08:06 -0700 (PDT)
In-Reply-To: <20260522082716.3598160-1-hsiangkao@linux.alibaba.com>
References: <20260522082716.3598160-1-hsiangkao@linux.alibaba.com>
From: Jianan Huang <jnhuang95@gmail.com>
Date: Fri, 22 May 2026 20:08:06 +0800
X-Gm-Features: AVHnY4JyxM3oVqQm1_u03KYpigtMYX6Xb3jGks-48GUb8aHuwi2EECIPg3Bs5ew
Message-ID: <CAJfKizpTV7NLbTrdQ-yRez76hU=2G9DARGb5K903G_GqfGzWPg@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix use-after-free on sbi->sync_decompress
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"oliver.yang@linux.alibaba.com" <oliver.yang@linux.alibaba.com>, 
	"syzbot+52bae5c495dbe261a0bc@syzkaller.appspotmail.com" <syzbot+52bae5c495dbe261a0bc@syzkaller.appspotmail.com>
Content-Type: multipart/alternative; boundary="000000000000ae8d87065266e1fe"
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
	autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.30 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_COUNT_ODD(1.00)[3];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:syzbot+52bae5c495dbe261a0bc@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jnhuang95@gmail.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.930];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jnhuang95@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3478-lists,linux-erofs=lfdr.de];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,52bae5c495dbe261a0bc];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email,appspotmail.com:email,syzkaller.appspot.com:url,u.work:url]
X-Rspamd-Queue-Id: 3EA095B3A9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000ae8d87065266e1fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jianan Huang <jnhuang95@gmail.com>

Thanks,
Jianan

=E5=9C=A8 2026=E5=B9=B45=E6=9C=8822=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=94=EF=
=BC=8CGao Xiang <hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A

> z_erofs_decompress_kickoff() can race with filesystem unmount, causing
> a use-after-free on sbi->sync_decompress.
>
> When I/O completes, z_erofs_endio() calls z_erofs_decompress_kickoff()
> to queue z_erofs_decompressqueue_work() asynchronously. Then, after all
> folios are unlocked, unmount workflow can proceed and sbi will be freed
> before accessing to sbi->sync_decompress.
>
> Thread (unmount)        I/O completion        kworker
>                         queue_work
>                                               z_erofs_decompressqueue_wor=
k
>                                                (all folios are unlocked)
> cleanup_mnt
>  ..
>  erofs_kill_sb
>   erofs_sb_free
>    kfree(sbi)
>                         access sbi->sync_decompress  // UAF!!
>
> Fixes: 40452ffca3c1 ("erofs: add sysfs node to control sync decompression
> strategy")
> Reported-by: syzbot+52bae5c495dbe261a0bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D52bae5c495dbe261a0bc
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 27ab7bd844ec..c6240dccbb0f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1455,6 +1455,9 @@ static void z_erofs_decompress_kickoff(struct
> z_erofs_decompressqueue *io,
>         if (atomic_add_return(bios, &io->pending_bios))
>                 return;
>         if (z_erofs_in_atomic()) {
> +               /* See `sync_decompress` in sysfs-fs-erofs for more
> details */
> +               if (sbi->sync_decompress =3D=3D EROFS_SYNC_DECOMPRESS_AUT=
O)
> +                       sbi->sync_decompress =3D EROFS_SYNC_DECOMPRESS_FO=
RCE_
> ON;
>  #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
>                 struct kthread_worker *worker;
>
> @@ -1471,9 +1474,6 @@ static void z_erofs_decompress_kickoff(struct
> z_erofs_decompressqueue *io,
>  #else
>                 queue_work(z_erofs_workqueue, &io->u.work);
>  #endif
> -               /* See `sync_decompress` in sysfs-fs-erofs for more
> details */
> -               if (sbi->sync_decompress =3D=3D EROFS_SYNC_DECOMPRESS_AUT=
O)
> -                       sbi->sync_decompress =3D EROFS_SYNC_DECOMPRESS_FO=
RCE_
> ON;
>                 return;
>         }
>         gfp_flag =3D memalloc_noio_save();
> --
> 2.43.5
>
>
>

--000000000000ae8d87065266e1fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jianan Huang &lt;<a href=3D"mailto:jnhuang95@gmail.com">jnhuan=
g95@gmail.com</a>&gt;<div><br></div><div>Thanks,</div><div>Jianan<br><br>=
=E5=9C=A8 2026=E5=B9=B45=E6=9C=8822=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=94=EF=
=BC=8CGao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangka=
o@linux.alibaba.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">z_erofs_decompress_kickoff() can race with filesystem unmoun=
t, causing<br>
a use-after-free on sbi-&gt;sync_decompress.<br>
<br>
When I/O completes, z_erofs_endio() calls z_erofs_decompress_kickoff()<br>
to queue z_erofs_decompressqueue_work() asynchronously. Then, after all<br>
folios are unlocked, unmount workflow can proceed and sbi will be freed<br>
before accessing to sbi-&gt;sync_decompress.<br>
<br>
Thread (unmount)=C2=A0 =C2=A0 =C2=A0 =C2=A0 I/O completion=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kworker<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 queue_work<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 z_erofs_decompressqueue_work<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(all folios are unlocked)<br>
cleanup_mnt<br>
=C2=A0..<br>
=C2=A0erofs_kill_sb<br>
=C2=A0 erofs_sb_free<br>
=C2=A0 =C2=A0kfree(sbi)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 access sbi-&gt;sync_decompress=C2=A0 // UAF!!<br>
<br>
Fixes: 40452ffca3c1 (&quot;erofs: add sysfs node to control sync decompress=
ion strategy&quot;)<br>
Reported-by: <a href=3D"mailto:syzbot+52bae5c495dbe261a0bc@syzkaller.appspo=
tmail.com">syzbot+52bae5c495dbe261a0bc@<wbr>syzkaller.appspotmail.com</a><b=
r>
Closes: <a href=3D"https://syzkaller.appspot.com/bug?extid=3D52bae5c495dbe2=
61a0bc
Signed-off-by" target=3D"_blank">https://syzkaller.appspot.com/<wbr>bug?ext=
id=3D52bae5c495dbe261a0bc<br>
Signed-off-by</a>: Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.=
com">hsiangkao@linux.alibaba.com</a>&gt;<br>
---<br>
=C2=A0fs/erofs/zdata.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c<br>
index 27ab7bd844ec..c6240dccbb0f 100644<br>
--- a/fs/erofs/zdata.c<br>
+++ b/fs/erofs/zdata.c<br>
@@ -1455,6 +1455,9 @@ static void z_erofs_decompress_kickoff(<wbr>struct z_=
erofs_decompressqueue *io,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (atomic_add_return(bios, &amp;io-&gt;pending=
_bios))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (z_erofs_in_atomic()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* See `sync_decomp=
ress` in sysfs-fs-erofs for more details */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sbi-&gt;sync_de=
compress =3D=3D EROFS_SYNC_DECOMPRESS_AUTO)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sbi-&gt;sync_decompress =3D EROFS_SYNC_DECOMPRESS_FORCE_<wbr>ON;<=
br>
=C2=A0#ifdef CONFIG_EROFS_FS_PCPU_KTHREAD<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct kthread_work=
er *worker;<br>
<br>
@@ -1471,9 +1474,6 @@ static void z_erofs_decompress_kickoff(<wbr>struct z_=
erofs_decompressqueue *io,<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_work(z_erofs_=
workqueue, &amp;io-&gt;<a href=3D"http://u.work" target=3D"_blank">u.work</=
a>);<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* See `sync_decomp=
ress` in sysfs-fs-erofs for more details */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sbi-&gt;sync_de=
compress =3D=3D EROFS_SYNC_DECOMPRESS_AUTO)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sbi-&gt;sync_decompress =3D EROFS_SYNC_DECOMPRESS_FORCE_<wbr>ON;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gfp_flag =3D memalloc_noio_save();<br>
-- <br>
2.43.5<br>
<br>
<br>
</blockquote></div>

--000000000000ae8d87065266e1fe--

