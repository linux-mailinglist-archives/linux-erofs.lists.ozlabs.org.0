Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C1019523D
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2020 08:43:50 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48pYkp65GxzDr0C
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2020 18:43:46 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 48pYjj746zzDqdc
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2020 18:42:49 +1100 (AEDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DD9E7B95B86398D5F4B2;
 Fri, 27 Mar 2020 15:42:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Mar
 2020 15:42:37 +0800
Subject: Re: [PATCH] erofs-utils: avoid PAGE_SIZE redefinition
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>, Li Guifu
 <bluce.liguifu@huawei.com>, Li GuiFu <bluce.lee@aliyun.com>
References: <20200325082930.2025-1-hsiangkao.ref@aol.com>
 <20200325082930.2025-1-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <32e6d75d-98dd-512a-ea3e-57f3506a7a5f@huawei.com>
Date: Fri, 27 Mar 2020 15:42:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200325082930.2025-1-hsiangkao@aol.com>
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

On 2020/3/25 16:29, Gao Xiang via Linux-erofs wrote:
> Buildroot autobuild reported a PAGE_SIZE redefinition with some
> configrations on i586 toolchain [1] (I didn't notice such report
> from erofs-utils travis CI or distribution builds before.)
> 
> In file included from config.c:11:
> ../include/erofs/internal.h:27: error: "PAGE_SIZE" redefined [-Werror]
>  #define PAGE_SIZE  (1U << PAGE_SHIFT)
> 
> In file included from ../include/erofs/defs.h:17,
>                  from ../include/erofs/config.h:12,
>                  from ../include/erofs/print.h:12,
>                  from config.c:10:
> .../sysroot/usr/include/limits.h:89: note: this is the location of the previous definition
>  #define PAGE_SIZE PAGESIZE
> 
> cc1: all warnings being treated as errors
> 
> Fix it now.
> 
> [1] http://autobuild.buildroot.net/results/340b98caa45bafd43f109002be9da59ba7f6d971
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
