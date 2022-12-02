Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705564057F
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Dec 2022 12:06:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NNqrY2Xgdz3bdh
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Dec 2022 22:06:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YBSuNHhs;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YBSuNHhs;
	dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NNqrT0W7yz3bNB
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Dec 2022 22:06:32 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id 6so4101535pgm.6
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Dec 2022 03:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTz51F9bsPoB86Y9QHHYRtEzGWPyrep/wS4rjmBJiCk=;
        b=YBSuNHhsY+1n0OeMkSuouxSlcj3anBw1J77GmKsXTHnymgbLPxu6nkZIA4kv1EgDaK
         QTvmXEL73aZm7ZJeglLw3PWUG5ieWOt8+blpUrBGAcPuERzVNirX2r606iHGEW+LARZ8
         N8OhxvBWDDQnOsH1//oMOXngN99+R2F1Af6v0yUtdWwhPohS2OzyWJ2pLDLTg/26NETI
         6+Yi6c95DP/pRCClUG4b20N0dulXEPjV83lnl7+d/i6uNqLVKurrS5bOS2ppToqSq7xy
         l4ifKG2Aikzqc+fTbSBv8dFFMcen48TbMRx0udwNIbF72YX6QWjLyNCZl8lWWv/8fOIN
         NxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTz51F9bsPoB86Y9QHHYRtEzGWPyrep/wS4rjmBJiCk=;
        b=L4t/tvSuM5PsRbZIpePIq7Qi8gr48Fw3qRRqClEtzpnteTAWY37AWnOzEkHbkaXFTV
         6fIaO4+7QMrZIFzkoPeiRNBkEahweeGIaLWzVxBzOjYM9e9CkR7R2QMOO5ziXy5rZHP+
         jOxwVPDt4oMvGvj1bWSeaTb1ccF+nEVkRG13jB5LEkq2x6xKBT9uS96lvZaFqAUxbDom
         vRRmIiMl3edwNlrqzpa2Hdi8WdJOMYw1NfY8IE0qIgZM7GVdoIuR/ZiH29F1t+T5UO7K
         2G23dpt/S5tvFiJL7HYGRRUGsy9jI1iYEkg8gQsBj+a0O63Kv3tMX38YPvcHjvr6B1V2
         slxw==
X-Gm-Message-State: ANoB5pmS58oypcoiXGrV1kpjAoVHNwXV747oQliDdeDIBvr+Uhccz2gZ
	32byXs7G0ghZ8Z/vKoWwixgaQnHLo7EDbA==
X-Google-Smtp-Source: AA0mqf4Uo/mmmpV03ILc3zfcom8L3eR4lgiYC3mr6bFrQ5apm6Fq2qt3XUmOhccrquo45qUQG1q9dw==
X-Received: by 2002:a63:eb16:0:b0:477:5f10:204f with SMTP id t22-20020a63eb16000000b004775f10204fmr44994558pgh.144.1669979189508;
        Fri, 02 Dec 2022 03:06:29 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id je10-20020a170903264a00b00186abb95bfdsm5342025plb.25.2022.12.02.03.06.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Dec 2022 03:06:29 -0800 (PST)
Date: Fri, 2 Dec 2022 19:10:42 +0800
From: Yue Hu <zbestahu@gmail.com>
To: <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v4] erofs-utils: mkfs: support fragment deduplication
Message-ID: <20221202191042.000004b9.zbestahu@gmail.com>
In-Reply-To: <20221201205358.00003061.huyue2@coolpad.com>
References: <20221201111615.9593-1-zbestahu@gmail.com>
	<20221201205358.00003061.huyue2@coolpad.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 01 Dec 2022 20:49:46 +0800
"Yue Hu" <huyue2@coolpad.com> wrote:

> Add a missing change:
> - change to generate a ctx for duplicate fragment in compression.
> 
> On Thu,  1 Dec 2022 19:16:15 +0800
> Yue Hu <zbestahu@gmail.com> wrote:
> 
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Previously, there's no fragment deduplication when this feature is
> > introduced. Let's support it now.
> > 
> > We intend to dedupe the fragments before compression, so that duplicate
> > parts will not be written into packed inode.
> > 
> > With this patch, for Linux 5.10.1 + 5.10.87 source code:
> > 
> > [before]
> >  32k pcluster + T0 + lz4hc,12 + fragment		450M
> >  64k pcluster + T0 + lz4hc,12 + fragment		434M
> > 128k pcluster + T0 + lz4hc,12 + fragment		426M
> >  32k pcluster + T0 + lz4hc,12 + fragment + dedupe	368M
> >  64k pcluster + T0 + lz4hc,12 + fragment + dedupe	380M
> > 128k pcluster + T0 + lz4hc,12 + fragment + dedupe	395M
> > 
> > [after]
> >  32k pcluster + T0 + lz4hc,12 + fragment		311M
> >  64k pcluster + T0 + lz4hc,12 + fragment		295M
> > 128k pcluster + T0 + lz4hc,12 + fragment		287M
> >  32k pcluster + T0 + lz4hc,12 + fragment + dedupe	286M
> >  64k pcluster + T0 + lz4hc,12 + fragment + dedupe	281M
> > 128k pcluster + T0 + lz4hc,12 + fragment + dedupe	278M
> > 
> > Tested on SquashFS (which uses level 12 by default for lz4hc):
> > 
> >  32k block + lz4hc		332M
> >  64k block + lz4hc		304M
> > 128k block + lz4hc		283M
> > 256k block + lz4hc		273M
> > 256k block + lz4hc + noI	278M
> > 
> > Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> > v4:
> > - renaming include tofcrc/new_fragmentsize
> > - move fixup into ctx
> > - use may_fixing to check packing fragment or not
> > - move sb/inode flag + 64bits case from erofs_pack_fragments() to new
> >   helper erofs_fragments_commit()
> > - move recompress ahead of may_inline case when compressing succeeds
> > - update commit message/code comments
> > - note that decompress will fail when enable ztailpacking at the same
> >   time, need some time to debug

No need to care may_inline case if we find duplicate fragment.

-               bool may_inline = (cfg.c_ztailpacking && final);
+               bool may_inline = (cfg.c_ztailpacking && final &&
+                                  !inode->fragment_size);

Should be included in v5.

> > 
> > v3:

