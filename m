Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F76028B5
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Oct 2022 11:48:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ms8FH0gmSz3c46
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Oct 2022 20:48:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ms8FC2Swtz3bjW
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Oct 2022 20:48:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VSUh59O_1666086503;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSUh59O_1666086503)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 17:48:24 +0800
Date: Tue, 18 Oct 2022 17:48:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y052Zvi91NaaYm7C@B-P7TQMD6M-0146.local>
References: <20221018035536.114792-1-hsiangkao@linux.alibaba.com>
 <202210181728.gXrmc8LC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210181728.gXrmc8LC-lkp@intel.com>
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
Cc: kbuild-all@lists.01.org, Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Oct 18, 2022 at 05:22:18PM +0800, kernel test robot wrote:
> Hi Gao,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on xiang-erofs/dev-test]
> [also build test ERROR on linus/master v6.1-rc1 next-20221018]

Thanks for the report, sorry for submitting an outdated version.
I'll merge the latest update and resend.

Thanks,
Gao Xiang
