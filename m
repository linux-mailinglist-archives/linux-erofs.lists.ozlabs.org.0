Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ACF3D06B7
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 04:27:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTzxS41Hcz2yWs
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 12:27:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ZL2tFxwr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12a;
 helo=mail-lf1-x12a.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ZL2tFxwr; dkim-atps=neutral
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTzxP1jhZz2yNK
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jul 2021 12:27:04 +1000 (AEST)
Received: by mail-lf1-x12a.google.com with SMTP id m16so895758lfg.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 19:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=IMEA7XUipMCPe6h8ouCsvI5CYO5wKR/xBeSj7gVT1/8=;
 b=ZL2tFxwrvAaDcgkunbrl2DXK4XIAXlxgvsjOXndmxdfQ1aP/4Oi8plfR3O0VsRQxf0
 Kj/IAHQTP8GgfPGfGebET4AOzmA/PyrMGb0D2skqhIVN8ZGr4m7y7dt9dY0HJ1YvZma+
 Hhly9/7QgO4cZ3IYYU0q3ebArfbUXGkcF1T+IssQW79jiLOkRyIDT9kS5wSXpUKIcLOP
 Byz6t0ncf330RJcnL5OoaL7Om/VfFJtU0KXn+O0cZaIzkieo4LWeopnRmZMEB6jodKSn
 iu3uwpNM8RQPwuKkfXg1+0rjQnsUlkA4190PRkHwObJXyUh2DsNWgGSBwbB+MjlFwoBC
 06vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=IMEA7XUipMCPe6h8ouCsvI5CYO5wKR/xBeSj7gVT1/8=;
 b=mhiKiCtM3jgiTYh/BNjsNnIyczsz+OhG+iy5yUI//vC/DEUIhNKIPpHVLLPRT8Pw/R
 PZxd5bSLosV8jRPdbz/ua84cMiDvzG53Df3bdSW1C8kANCiWOlMRRcpHFte2/aFfhJnE
 UhX1e/WzNrWss26MSVStnstaN8h+C2fGFAFphUp79gFzQCWS8Z9/AGioAgQEia2nyc4R
 kz0XN19PdAu7Ft5kVSVKxO1dRvVNPCOg7tsa7XHEwb67moWGYkk+TQcDA3kEOzH44Nc2
 MIvZW8iOaLjddZgUZcUa+SdPndzM/m09vFggWvrw//9Q4YMORS6CyAtfTArKYpzGcfKR
 r2Iw==
X-Gm-Message-State: AOAM531Q7qsgnqy2FgDq9ZWu9yGnf4KfRDMkJrCiyiwot01rtyPSw/V9
 S6Rz30R/oFWAD4PjUE5elHJlfzAywwJDMlpof4w=
X-Google-Smtp-Source: ABdhPJy6dCrVihE64G/2FDHlAuzGdom8CulvBOLoo9EPFdwRFwalBwnjn6yQF+6SCWyYI7tIAeVjr0Y7QC+APrGtAFU=
X-Received: by 2002:ac2:5482:: with SMTP id t2mr24222408lfk.135.1626834420374; 
 Tue, 20 Jul 2021 19:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia> <YPc9viRAKm6cf2Ey@casper.infradead.org>
 <YPdkYFSjFHDOU4AV@B-P7TQMD6M-0146.local> <20210721001720.GS22357@magnolia>
 <YPdrSN6Vso98bLzB@B-P7TQMD6M-0146.local>
In-Reply-To: <YPdrSN6Vso98bLzB@B-P7TQMD6M-0146.local>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Wed, 21 Jul 2021 04:26:47 +0200
Message-ID: <CAHpGcM+8cp81=bkzFf3sZfKREM9VbXfePpXrswNJOLVcwEnK7A@mail.gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
To: "Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-erofs@lists.ozlabs.org, 
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Am Mi., 21. Juli 2021 um 02:33 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> > And since you can only kmap one page at a time, an inline read grabs the
> > first part of the data in "page one" and then we have to call
> > iomap_begin a second time get a new address so that we can read the rest
> > from "page two"?
>
> Nope, currently EROFS inline data won't cross page like this.
>
> But in principle, yes, I don't want to limit it to the current
> EROFS or gfs2 usage. I think we could make this iomap function
> more generally (I mean, I'd like to make the INLINE extent
> functionity as general as possible,

Nono. Can we please limit this patch what we actually need right now,
and worry about extending it later?

> my v1 original approach
> in principle can support any inline extent in the middle of
> file rather than just tail blocks, but zeroing out post-EOF
> needs another iteration) and I don't see it add more code and
> complexity.

Thanks,
Andreas
