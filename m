Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D234DA966
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 05:45:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJHl33ygtz30CP
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 15:45:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJHkx1SdXz2ywv
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 15:45:10 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R881e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V7L7Vd._1647405899; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7L7Vd._1647405899) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Mar 2022 12:45:00 +0800
Date: Wed, 16 Mar 2022 12:44:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>
Subject: Re: [PATCH] erofs: rename ctime to mtime
Message-ID: <YjFrSivX//3sGdSr@B-P7TQMD6M-0146.local>
References: <20220311041829.3109511-1-dvander@google.com>
 <YirUWDjLn21E382Q@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YirUWDjLn21E382Q@B-P7TQMD6M-0146.local>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Fri, Mar 11, 2022 at 12:47:20PM +0800, Gao Xiang wrote:
> Hi David,
> 
> On Fri, Mar 11, 2022 at 04:18:29AM +0000, David Anderson via Linux-erofs wrote:
> > EROFS images should inherit modification time rather than creation time,
> > since users and host tooling have no easy way to control creation time.
> > To reflect the new timestamp meaning, i_ctime and i_ctime_nsec are
> > renamed to i_mtime and i_mtime_nsec.
> > 
> > Signed-off-by: David Anderson <dvander@google.com>
> 
> Thanks for the patch!
> 
> This patch looks good to me, yet, should we update
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/erofs.rst#n43
> 
> here as well? (I think "Inode timestamp" might be fine..)

Since another -rc8 is out, would you mind revising the patch with
the document update... Or would you mind if I could help revise it?

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
