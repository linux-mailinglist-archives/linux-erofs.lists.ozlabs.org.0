Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFADA1121CC
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Dec 2019 04:15:05 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47SP9L2Db3zDqSp
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Dec 2019 14:15:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47SP9F1PMJzDqSK
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Dec 2019 14:14:56 +1100 (AEDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 885B553BE6C41356A36B;
 Wed,  4 Dec 2019 11:14:48 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Dec 2019
 11:14:38 +0800
Subject: Re: [PATCH] erofs: zero out when listxattr is called with no xattr
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>
References: <20191201084040.29275-1-hsiangkao.ref@aol.com>
 <20191201084040.29275-1-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <947ae429-d206-0859-ee5b-9bd37f7fd72b@huawei.com>
Date: Wed, 4 Dec 2019 11:14:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191201084040.29275-1-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
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
Cc: David Michael <fedora.dm0@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Wang Li <wangli74@huawei.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/12/1 16:40, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As David reported [1], ENODATA returns when attempting
> to modify files by using EROFS as a overlayfs lower layer.
> 
> The root cause is that listxattr could return unexpected
> -ENODATA by mistake for inodes without xattr. That breaks
> listxattr return value convention and it can cause copy
> up failure when used with overlayfs.
> 
> Resolve by zeroing out if no xattr is found for listxattr.
> 
> [1] https://lore.kernel.org/r/CAEvUa7nxnby+rxK-KRMA46=exeOMApkDMAV08AjMkkPnTPV4CQ@mail.gmail.com
> Fixes: cadf1ccf1b00 ("staging: erofs: add error handling for xattr submodule")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
