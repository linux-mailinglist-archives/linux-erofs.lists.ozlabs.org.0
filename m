Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E617A2FD3
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 08:26:06 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KTy33XnnzF0ZQ
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 16:26:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KTxy1lPPzDr68
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 16:25:57 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 60F2F1550EE73DC9E70F;
 Fri, 30 Aug 2019 14:25:55 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 14:25:49 +0800
Subject: Re: [PATCH v3 7/7] erofs: redundant assignment in
 __erofs_get_meta_page()
To: Gao Xiang <gaoxiang25@huawei.com>, Dan Carpenter
 <dan.carpenter@oracle.com>, Christoph Hellwig <hch@infradead.org>, "Joe
 Perches" <joe@perches.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <devel@driverdev.osuosl.org>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-7-gaoxiang25@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <82a5a7e0-eee2-0b57-f22f-1771b82a16f7@huawei.com>
Date: Fri, 30 Aug 2019 14:25:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190830033643.51019-7-gaoxiang25@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/8/30 11:36, Gao Xiang wrote:
> As Joe Perches suggested [1],
>  		err = bio_add_page(bio, page, PAGE_SIZE, 0);
> -		if (unlikely(err != PAGE_SIZE)) {
> +		if (err != PAGE_SIZE) {
>  			err = -EFAULT;
>  			goto err_out;
>  		}
> 
> The initial assignment to err is odd as it's not
> actually an error value -E<FOO> but a int size
> from a unsigned int len.
> 
> Here the return is either 0 or PAGE_SIZE.
> 
> This would be more legible to me as:
> 
> 		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
> 			err = -EFAULT;
> 			goto err_out;
> 		}
> 
> [1] https://lore.kernel.org/r/74c4784319b40deabfbaea92468f7e3ef44f1c96.camel@perches.com/
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
