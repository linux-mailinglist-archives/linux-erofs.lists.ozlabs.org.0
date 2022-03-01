Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 845974C83C2
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 07:14:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K76RD52vsz3bpH
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 17:14:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K76R71nX9z3bdL
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Mar 2022 17:14:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V5tShBt_1646115275; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V5tShBt_1646115275) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 01 Mar 2022 14:14:36 +0800
Date: Tue, 1 Mar 2022 14:14:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Use extended inodes when ctime is set
Message-ID: <Yh25yvTzxt0aK62a@B-P7TQMD6M-0146.local>
References: <20220301041037.2271718-1-dvander@google.com>
 <Yh2sc2TOmyBdV3b7@B-P7TQMD6M-0146.local>
 <CA+FmFJB0iDzcPLqAtZsqQFj+j-pvhqs9YXmhjkmCYyqPgHpxnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+FmFJB0iDzcPLqAtZsqQFj+j-pvhqs9YXmhjkmCYyqPgHpxnA@mail.gmail.com>
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

On Mon, Feb 28, 2022 at 10:06:33PM -0800, David Anderson wrote:
> On Mon, Feb 28, 2022 at 9:17 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > How about introducing some option like '-E preserve-time' since
> > compact inodes are mainly used for reproducible builds, which I think
> > per-file timestamp is useless...
> >
> > Also after I checked ociv2-brainstorm, they'd like to avoid timestamp as
> > well, which can be effective used by EROFS compact inodes...
> 
> Sounds good, I'll post a new patch with this option.

(Or maybe just "--preserve-mtime" if it's supposed to be used frequently in
 specific use cases...)

Thanks,
Gao Xiang

> 
> Best,
> 
> -David
