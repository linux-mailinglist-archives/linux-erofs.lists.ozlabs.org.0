Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC544AC96
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 12:26:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpQfV1Nmyz2yNW
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 22:26:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpQfQ3ZWrz2xBT
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 22:26:21 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R541e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0UvmuBey_1636457161; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UvmuBey_1636457161) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 09 Nov 2021 19:26:03 +0800
Date: Tue, 9 Nov 2021 19:26:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Daeho Jeong <daeho43@gmail.com>
Subject: Re: [PATCH v3] erofs-utils: introduce fsck.erofs
Message-ID: <YYpaySr6vGEfwduR@B-P7TQMD6M-0146.local>
References: <20211029171312.2189648-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211029171312.2189648-1-daeho43@gmail.com>
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-erofs@lists.ozlabs.org,
 jaegeuk@kernel.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Daeho,

On Fri, Oct 29, 2021 at 10:13:12AM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> I made a fsck.erofs tool to check erofs filesystem image integrity
> and calculate filesystem compression ratio.
> Here are options to support now.
> 
> fsck.erofs [options] IMAGE
> -V      print the version number of fsck.erofs and exit.
> -d#     set output message level to # (maximum 9)
> -p      print total compression ratio of all files
> -c      check if all compressed files are well decompressed
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Applied with some minor updates, e.g. update .gitignore, etc.
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=f44043561491255c37903a9ad1334f2e88c95005

Thanks,
Gao Xiang

