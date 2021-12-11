Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B957D471130
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 04:30:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9tZJ28Cfz3cNB
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 14:30:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9tZC34cFz3c9d
 for <linux-erofs@lists.ozlabs.org>; Sat, 11 Dec 2021 14:30:10 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V-CmmiW_1639193388; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-CmmiW_1639193388) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 11 Dec 2021 11:29:50 +0800
Date: Sat, 11 Dec 2021 11:29:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: erofs-utils: fsck support for --extract=X to extract to path X
Message-ID: <YbQbK+eZYR65DZx7@B-P7TQMD6M-0146.local>
References: <CABjEcnHHFe-1YbWjcpMXXuM8Dd1a+tgWTbATP5hOhQ_+PDBZMw@mail.gmail.com>
 <20211211102110.00000a8f.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211211102110.00000a8f.zbestahu@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, Igor Eisberg <igoreisberg@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Dec 11, 2021 at 10:21:10AM +0800, Yue Hu wrote:
> Hi Igor,
> 
> On Fri, 10 Dec 2021 17:53:13 +0200
> Igor Eisberg <igoreisberg@gmail.com> wrote:
> 
> The patch should be submitted by e-mail "inline". The easiest way to do this
> is usine "git send-email" which is strongly recommended.
> 

Hi Yue,

No problem, it seems fine on my side as long as it has proper SOB.
Actually there is still some work to do before applying (also IMO,
dump.erofs and fsck.erofs codebases are still somewhat messy), I
need to polish it later.

Thanks,
Gao Xiang


> Thanks.
