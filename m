Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D2473AE7
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 03:50:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCjYY3pJKz304y
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 13:50:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCjYT5bWrz2ypK
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 13:50:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V-Zl.d9_1639450230; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-Zl.d9_1639450230) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 14 Dec 2021 10:50:31 +0800
Date: Tue, 14 Dec 2021 10:50:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v3 2/2] Add API to iterate over inodes in EROFS
Message-ID: <YbgGdXD0yYpE4B5Y@B-P7TQMD6M-0146.local>
References: <20211214004311.GA2891@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20211214021955.992899-1-zhangkelvin@google.com>
 <20211214021955.992899-2-zhangkelvin@google.com>
 <CAOSmRzjd4j+Zus+cnor+X0bwMbdBGp4V=Pm89Co0_BeH=mt6FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOSmRzjd4j+Zus+cnor+X0bwMbdBGp4V=Pm89Co0_BeH=mt6FQ@mail.gmail.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 13, 2021 at 06:25:09PM -0800, Kelvin Zhang wrote:
> Fixed most of the issues you pointed out. Except I didn't quite understand
> the "nid is optional unless we do a fsck." part. Not sure how we can
> implement the iterate dir function w/o nid. Can you provide more context?

There were two nids there, parent_nid and nid. I meant you could leave
dir nid (no matter how it's called) mandatorily. dir's parent nid is
optional.

Sorry if I made some confusion at that time.

Thanks,
Gao Xiang
