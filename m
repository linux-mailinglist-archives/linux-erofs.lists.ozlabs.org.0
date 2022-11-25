Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 091FC6385A1
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Nov 2022 09:55:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NJTGW28hSz3cdy
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Nov 2022 19:55:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NJTGR0BWDz3c2j
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Nov 2022 19:55:25 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VVefQ1k_1669366518;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VVefQ1k_1669366518)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 16:55:20 +0800
Date: Fri, 25 Nov 2022 16:55:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [External] [PATCH] erofs: check the uniqueness of fsid in shared
 domain in advance
Message-ID: <Y4CC9dqtuHEITdlt@B-P7TQMD6M-0146.local>
References: <20221125074057.2229083-1-houtao@huaweicloud.com>
 <49b2b8e4-39d0-983c-23c6-f18232a7dff3@bytedance.com>
 <86bf6991-d46b-be95-06a7-87829e8c5e33@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86bf6991-d46b-be95-06a7-87829e8c5e33@huaweicloud.com>
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
Cc: linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, houtao1@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


Hi Tao,

On Fri, Nov 25, 2022 at 04:39:47PM +0800, Hou Tao wrote:
> Hi,
> 
> On 11/25/2022 4:25 PM, Jia Zhu wrote:
> > Hi Tao,
> > We've noticed this warning during development. It seems not a bug, so
> > I ignored that.
> > Many thanks for cacthing and clearing up the annoying warning.
> Yes, it is not a bug. The duplicated mount will fail with -EEXIST even without
> the patch. But it is a bit scary to see such warning in dmesg, so just fix it.

Thanks for the catch.

IMO, a WARN is indeed a bug, we cannot rely on this.

Overall the patch itself looks good to me as well, please help Cc LKML
mailing list as well in v2...

Thanks,
Gao Xiang
