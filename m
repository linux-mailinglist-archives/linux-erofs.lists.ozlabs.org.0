Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15F91627AF
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 15:08:21 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MN4307j2zDqSc
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 01:08:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582034899;
	bh=+N3O+ip1gStyUcv+NVhb+9w2+PeTmzC0tui3wydrYTY=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NHgRHnNMhLLW2XbyzD+0ukpmRD3BigHxDz30ax+5zRdwWMX6gTK2SLbL19bNYzplt
	 rgTn4A/c/YCHKA+U62Zd/jLyH57sa1PF82gRgSiKrSy6F/rcMUocQYZqBSBXY2oVyl
	 Vn04xkmF+Pdo8q/V4o+was4m/i0sj9pX7o+H6Thw7gxbQg9ZDfkSgwvTFJ/xFoFcAd
	 j7lT8VQvKS+gFOylh49C3ofCzjVExpWVTmDNJojeWEy0p+Eb1LBiChSdz/sd2syauD
	 NoHv7DatfM0qIq3rHHJn+5GvCC2TvQxVRTUHGjMm0bkv2UY8Wfp2lqxyIHume7HNGl
	 7bljzsuxEsJeA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.4;
 helo=out30-4.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=NjH//N4A; dkim-atps=neutral
Received: from out30-4.freemail.mail.aliyun.com
 (out30-4.freemail.mail.aliyun.com [115.124.30.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MN0T4btyzDqgM
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 01:05:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1582034694; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=+N3O+ip1gStyUcv+NVhb+9w2+PeTmzC0tui3wydrYTY=;
 b=NjH//N4ALeETQNIH1w5Vwfq2czURjs6HhigEJf3lY0OsrGCkn7mBD91pD2GkHhh/WPxnAfOd6kgX7+WQDKLdjtCUuJ0L0D1Zt6Swf5rp1QH/3hTmZ6DtNwrCKOoNUx8rPyNmHe2E0WkFhyGmnVNR717v8d+RsndMzXS1RtRmHUM=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1427132|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.0613299-0.000903204-0.937767;
 DS=CONTINUE|ham_regular_dialog|0.0181494-0.00449912-0.977351;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04426; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---0TqIHai0_1582034692; 
Received: from 192.168.0.101(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0TqIHai0_1582034692) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 18 Feb 2020 22:04:52 +0800
Subject: Re: [PATCH v6] erofs-utils: introduce exclude dirs and files
To: Gao Xiang <gaoxiang25@huawei.com>
References: <20200217131653.54489-1-bluce.lee@aliyun.com>
 <20200218023214.GA215954@architecture4>
Message-ID: <fcc63e13-110d-6c9d-b2c1-e731b3eab33b@aliyun.com>
Date: Tue, 18 Feb 2020 22:04:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218023214.GA215954@architecture4>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Good idea

On 2020/2/18 10:32, Gao Xiang wrote:
> On Mon, Feb 17, 2020 at 09:16:53PM +0800, Li Guifu wrote:
>> From: Li GuiFu <bluce.lee@aliyun.com>
>>
>> Add excluded file feature "--exclude-path=" and '--exclude-regex=',
>> which can be used to build EROFS image without some user specific
>> files or dirs. Note that you may give multiple '--exclude-path'
>> or '--exclude-regex' options.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
