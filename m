Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 39355BA18C
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Sep 2019 10:42:32 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46bgts5kK7zDqPv
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Sep 2019 18:42:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46bgtn1cpXzDqPc
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2019 18:42:23 +1000 (AEST)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 47D16A3DAE455B128752;
 Sun, 22 Sep 2019 16:42:17 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 22 Sep 2019 16:42:17 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sun, 22 Sep 2019 16:42:16 +0800
Date: Sun, 22 Sep 2019 16:41:04 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] erofs: fix erofs_get_meta_page locking by a cleanup
Message-ID: <20190922084101.GA114049@architecture4>
References: <20190921073035.209811-1-gaoxiang25@huawei.com>
 <20190922083205.GN13569@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190922083205.GN13569@xsang-OptiPlex-9020>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 kbuild-all@01.org, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Sun, Sep 22, 2019 at 04:32:05PM +0800, kbuild test robot wrote:
> 
> All warnings (new ones prefixed by >>):
> 
>    fs//erofs/data.c: In function 'erofs_get_meta_page':
> >> fs//erofs/data.c:43:10: warning: return makes pointer from integer without a cast [-Wint-conversion]
>       return PTR_ERR(page);

It was already fixed in v2.

Thanks,
Gao Xiang

