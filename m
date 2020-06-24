Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 992862069A5
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2020 03:43:17 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49s5Wk0DXbzDqcj
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2020 11:43:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49s5Wb2HcgzDqX3
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2020 11:43:03 +1000 (AEST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8AD91B060A5B3297B7E7;
 Wed, 24 Jun 2020 09:42:57 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 24 Jun
 2020 09:42:47 +0800
Subject: Re: [PATCH v2] erofs: fix partially uninitialized misuse in
 z_erofs_onlinepage_fixup
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>
References: <20200618111936.19845-1-hsiangkao@aol.com>
 <20200618234349.22553-1-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <d9d2570a-ce51-79a7-6cc4-bd5e6f15cb4a@huawei.com>
Date: Wed, 24 Jun 2020 09:42:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200618234349.22553-1-hsiangkao@aol.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Hongyu Jin <hongyu.jin@unisoc.com>,
 stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/6/19 7:43, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> Hongyu reported "id != index" in z_erofs_onlinepage_fixup() with
> specific aarch64 environment easily, which wasn't shown before.
> 
> After digging into that, I found that high 32 bits of page->private
> was set to 0xaaaaaaaa rather than 0 (due to z_erofs_onlinepage_init
> behavior with specific compiler options). Actually we only use low
> 32 bits to keep the page information since page->private is only 4
> bytes on most 32-bit platforms. However z_erofs_onlinepage_fixup()
> uses the upper 32 bits by mistake.
> 
> Let's fix it now.
> 
> Reported-by: Hongyu Jin <hongyu.jin@unisoc.com>
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
