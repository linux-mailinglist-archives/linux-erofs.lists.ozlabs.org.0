Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA7819522F
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2020 08:40:54 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48pYgQ1LCZzDqb5
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2020 18:40:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48pYg810mNzDqWS
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2020 18:40:30 +1100 (AEDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id DBC6541DD72FF724A76A;
 Fri, 27 Mar 2020 15:40:20 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Mar
 2020 15:40:12 +0800
Subject: Re: [PATCH] erofs-utils: avoid _LARGEFILE64_SOURCE and _GNU_SOURCE
 redefinition
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>, Li Guifu
 <bluce.liguifu@huawei.com>, Li GuiFu <bluce.lee@aliyun.com>
References: <20200314105256.20142-1-hsiangkao.ref@aol.com>
 <20200314105256.20142-1-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <ff5c9cdb-5eeb-2d3b-b7fa-fdc16d7fadaf@huawei.com>
Date: Fri, 27 Mar 2020 15:40:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200314105256.20142-1-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/3/14 18:52, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> This patch can be used to resolve the following build errors:
> 
> compress.c:10: error: "_LARGEFILE64_SOURCE" redefined [-Werror]
>  #define _LARGEFILE64_SOURCE
> 
> <command-line>: note: this is the location of the previous definition
> 
> io.c:9: error: "_LARGEFILE64_SOURCE" redefined [-Werror]
>  #define _LARGEFILE64_SOURCE
> 
> <command-line>: note: this is the location of the previous definition
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
