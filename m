Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23572D254F
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 09:03:21 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqt390h1vzDqX8
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 19:03:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqt316H4wzDqQG
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 19:03:03 +1100 (AEDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cqscl3vXQz15Z8X;
 Tue,  8 Dec 2020 15:43:51 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 8 Dec 2020
 15:44:18 +0800
Subject: Re: [PATCH] erofs: remove a void EROFS_VERSION macro set in Makefile
To: Vladimir Zapolskiy <vladimir@tuxera.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>
References: <20201030122839.25431-1-vladimir@tuxera.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <573bebbc-039b-4359-a2d6-851272f27f70@huawei.com>
Date: Tue, 8 Dec 2020 15:44:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201030122839.25431-1-vladimir@tuxera.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/10/30 20:28, Vladimir Zapolskiy wrote:
> Since commit 4f761fa253b4 ("erofs: rename errln/infoln/debugln to
> erofs_{err, info, dbg}") the defined macro EROFS_VERSION has no affect,
> therefore removing it from the Makefile is a non-functional change.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
