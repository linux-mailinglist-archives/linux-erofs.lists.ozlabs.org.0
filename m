Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A4473B35
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 03:59:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCjll2Ps5z304n
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 13:59:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639450787;
	bh=qKekMpTwenb0Drr+3NzJnCMec0j8G36fHEus5cKLb+U=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HYsQ8gJ7RfqlMo2dPiOeJ6XkhEiCCI2PnsCefeGrEPXv2DJHcx/8O0Aygi47Hu8v4
	 v9miCACYL8RnE/hyOo+H2oLglN5gNVMnmlpTVLzZGPNP706nd2p7bN+mGAzoEtVdhd
	 I3832mJrXTAKJDR+JJR5x3BZLmPdQwAXF/kMxOXw807G2G2dMiApncTE/FbqyU7Myi
	 luNmNqQHBzTlSE+9RKzYojTiznYTA4pVESzKgTO9U7r6UzMxfeLUkle468VJEPdGCR
	 BODiqg3/hWErnY4iYjjNWCZirnKh7WVYcKJ6TwOwRVQuXc+OnAsaUJpS1xHVdx87XH
	 f4yAxPbcQcLOg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::f2b;
 helo=mail-qv1-xf2b.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=flpZMf9u; dkim-atps=neutral
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCjlf62Kjz2xtQ
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 13:59:42 +1100 (AEDT)
Received: by mail-qv1-xf2b.google.com with SMTP id jo22so16202614qvb.13
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Dec 2021 18:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qKekMpTwenb0Drr+3NzJnCMec0j8G36fHEus5cKLb+U=;
 b=zBRSQ8l0gdTfhcQGJWBkKiZvpy+EDLPRb+sc5/yZlecLneS9LNm0F/9oh/p03omDuY
 a9hJ/Gzzvye1UpCcyN7EKdmvPUZXBv/22lGYdSdg5YdrTagMVHnwxBO964YssT59UvLv
 uakCe2F/fRIP0R922niDdiQltpjFYA2khKWRAfKHKJvXmQkTUKz4LFm32kEDlNUSCKVn
 yVGkEn0Lnbkpif6f2zgGn4NLL3/U9z/avRcfgS79wfoubpnovROlO13oxRNHX36ZW1wb
 ls0TdF7ICttdbF5Y6gdBhdIRRVbmES9KsZTL02TgNuphCxBunF1QBigzb6tBZZpgjG40
 zFVQ==
X-Gm-Message-State: AOAM5317urhDg+dO0R0QFoTjtUZnp8NkLKyUOM7s0qaNX+wT2U7Wl8o7
 usvJ9b+PmfR5p8squzolZYaiKQ4wulqxGXhmqyKRDA==
X-Google-Smtp-Source: ABdhPJxobkI13JRA2ydugHFXSupI2MRw02b0aLjlzIAdmV8s9wTIBzDIDaY3H6EIDatdp+BHLP69VGV9Nr0kdIo6eUU=
X-Received: by 2002:ad4:4373:: with SMTP id u19mr2535755qvt.123.1639450779122; 
 Mon, 13 Dec 2021 18:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20211214004311.GA2891@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20211214021955.992899-1-zhangkelvin@google.com>
 <20211214021955.992899-2-zhangkelvin@google.com>
 <CAOSmRzjd4j+Zus+cnor+X0bwMbdBGp4V=Pm89Co0_BeH=mt6FQ@mail.gmail.com>
 <YbgGdXD0yYpE4B5Y@B-P7TQMD6M-0146.local>
In-Reply-To: <YbgGdXD0yYpE4B5Y@B-P7TQMD6M-0146.local>
Date: Mon, 13 Dec 2021 18:59:28 -0800
Message-ID: <CAOSmRzh4VgVVbwSSoRwi3B589qrQ0AFMDSJa+honkNkf3V3asg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Add API to iterate over inodes in EROFS
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000516f3805d312610b"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000516f3805d312610b
Content-Type: text/plain; charset="UTF-8"

I think we still need parent_nid to skip "." and ".." directories
correctly? Let's leave these parameters there.

On Mon, Dec 13, 2021 at 6:50 PM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> On Mon, Dec 13, 2021 at 06:25:09PM -0800, Kelvin Zhang wrote:
> > Fixed most of the issues you pointed out. Except I didn't quite
> understand
> > the "nid is optional unless we do a fsck." part. Not sure how we can
> > implement the iterate dir function w/o nid. Can you provide more context?
>
> There were two nids there, parent_nid and nid. I meant you could leave
> dir nid (no matter how it's called) mandatorily. dir's parent nid is
> optional.
>
> Sorry if I made some confusion at that time.
>
> Thanks,
> Gao Xiang
>


-- 
Sincerely,

Kelvin Zhang

--000000000000516f3805d312610b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think we still need parent_nid to skip &quot;.&quot; and=
 &quot;..&quot; directories correctly? Let&#39;s leave these parameters the=
re.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Mon, Dec 13, 2021 at 6:50 PM Gao Xiang &lt;<a href=3D"mailto:hsiangka=
o@linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Dec 13, 2021 at 06:=
25:09PM -0800, Kelvin Zhang wrote:<br>
&gt; Fixed most of the issues you pointed out. Except I didn&#39;t quite un=
derstand<br>
&gt; the &quot;nid is optional unless we do a fsck.&quot; part. Not sure ho=
w we can<br>
&gt; implement the iterate dir function w/o nid. Can you provide more conte=
xt?<br>
<br>
There were two nids there, parent_nid and nid. I meant you could leave<br>
dir nid (no matter how it&#39;s called) mandatorily. dir&#39;s parent nid i=
s<br>
optional.<br>
<br>
Sorry if I made some confusion at that time.<br>
<br>
Thanks,<br>
Gao Xiang<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Sincerely,<div><br></div><div>K=
elvin Zhang</div></div></div>

--000000000000516f3805d312610b--
