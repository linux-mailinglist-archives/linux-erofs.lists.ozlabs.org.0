Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D0F72F81
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 15:05:43 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45twZF22PwzDqMx
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 23:05:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45twZ613XpzDq74
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 23:05:33 +1000 (AEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BD2BC686F59360116076
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 21:05:28 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Jul
 2019 21:05:18 +0800
Subject: Re: [PATCH v3] erofs-utils: Add missing error code handling.
To: Pratik Shinde <pratikshinde320@gmail.com>, <linux-erofs@lists.ozlabs.org>, 
 <bluce.liguifu@huawei.com>, <miaoxie@huawei.com>, <fangwei1@huawei.com>
References: <20190724091246.10367-1-pratikshinde320@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <09fdf506-bba5-429f-d5d5-f6f05ba515d4@huawei.com>
Date: Wed, 24 Jul 2019 21:04:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190724091246.10367-1-pratikshinde320@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
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



On 2019/7/24 17:12, Pratik Shinde wrote:
> Handling error conditions that are missed in few scenarios.
> also, mkfs command should return 1 on failure and 0 on success.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>

looks good to me, will apply later....
(since Li Guifu cannot send outgoing email...I will apply directly.)

Thanks,
Gao Xiang
