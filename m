Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 96455473B2F
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 03:58:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCjjt3dL6z304y
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 13:58:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=pHu+4kPl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=pHu+4kPl; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCjjp1XbGz2yZt
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 13:58:04 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id v16so81193pjn.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Dec 2021 18:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=re3zzuDZyW9jOhYFK69BG4SXWlMMDFfXk8PXBLga6Tk=;
 b=pHu+4kPlZMs4SBK80xw6vi+PNb9iH98iYVEZAomBNpmiXtz1LJeoCvNmEjAMIngCfY
 yryz/T8c+yNBEc1IkjJZDqC6KfbCJwnfc8kGDNZYSwGEUhjsNpzYjKRobVipiTMzl2xR
 LPch75GE+//gXZlyjR4lBWqcUYiF5f0g9Y945+eSsg3Gbmf9gwmOHPxG4vBe9Sk9gkIs
 FeMB7X6OaFD0kj1NwISCHPCl+UzCxiDX7SGNlHlRhrLCfQoiwnCw13I+MDyCyE1LiPi4
 iRs6j6l5y52NNQvXjW4TZPpna2v0/s+1XPW1po4zWPnqWcOW0kNUuuOQXreWk5bF3lT4
 GGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=re3zzuDZyW9jOhYFK69BG4SXWlMMDFfXk8PXBLga6Tk=;
 b=mdoNZd1cWI4buTbfFEpCFNMpWTev1D5qFqUQee0A+PReelSxWyvWZfst7Y5d4uF6E8
 bt8QHB2WA29ddcET7eFb1OlwokbqBFq0hkkY2XUvTLJ4PR8Z9szktRotxEAYyCFdsxLU
 fCmmafbPZNK9Vrc1rfGWokbj7mzIRpm9kAVpo3AC4uqKK0HW1GIAMA/ASZ5nU1nVHwap
 zFAIGc+WEp55SAPmDiJo8iD5K7cHcqb/HzlWuopRpwnHvceoifc9/jObx1V6cOXT91CO
 RBIHGAOZNcidzlN3TAVUiSUaCPFEjT43TeddXoEUPBcrXFwJDyxlgpW4iDi1cfzsj9Io
 5eQQ==
X-Gm-Message-State: AOAM530/DOqXgQ38slGeBoaIU0Cxv7kAC5aGcW7x2ngEFbcd+w+13g+I
 gVEaHsNUUh3dNRCvpQruh9E=
X-Google-Smtp-Source: ABdhPJzSCyoSrMNb4uEqHwr9xXLlRP9JOnERaMJmhom5xquB+I0lU9jtMdwf7uI7pCGlJPsTPbuJoQ==
X-Received: by 2002:a17:902:7289:b0:142:805f:e2c with SMTP id
 d9-20020a170902728900b00142805f0e2cmr2404183pll.42.1639450681373; 
 Mon, 13 Dec 2021 18:58:01 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id h13sm12775859pfv.37.2021.12.13.18.57.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 13 Dec 2021 18:58:01 -0800 (PST)
Date: Tue, 14 Dec 2021 10:55:48 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH v5 1/2] erofs-utils: fuse: support tail-packing
 inline compressed data
Message-ID: <20211214105548.00001ca8.zbestahu@gmail.com>
In-Reply-To: <YbgHdzA0FtXa4lHh@B-P7TQMD6M-0146.local>
References: <1fc2694139fa8b217208992c72ec8ef383e3ff9e.1639377756.git.huyue2@yulong.com>
 <YbcqArpVrEXjLzW/@B-P7TQMD6M-0146.local>
 <YbgHdzA0FtXa4lHh@B-P7TQMD6M-0146.local>
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
Cc: geshifei@coolpad.com, zhangwen@coolpad.com, Yue Hu <huyue2@yulong.com>,
 linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 14 Dec 2021 10:54:47 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Mon, Dec 13, 2021 at 07:09:54PM +0800, Gao Xiang wrote:
> > Hi Yue,
> > 
> > On Mon, Dec 13, 2021 at 02:50:54PM +0800, Yue Hu wrote:  
> > > Add tail-packing inline compressed data support for erofsfuse.
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> > 
> > This version almost looks fine to me, no need to update. I will polish
> > it this week.
> >  
> 
> I've applied this patch
> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-ztailpacking
> 
> Would you mind rebasing [PATCH 2/2] on this and resending? It saves much
> time for me. (Actually the development process needs to be based on the
> latest dev branch other than on some random commit.)

no problem, i will do it later.

Thanks.

> 
> Thanks,
> Gao Xiang

