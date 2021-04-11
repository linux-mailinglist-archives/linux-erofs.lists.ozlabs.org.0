Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20235B5BF
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 16:56:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJFLw6XYJz30Bw
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Apr 2021 00:56:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1618153000;
	bh=Jv0R+kqOtFbJjkpF86I0HX3cwr9T9sDVzP7P8hGpCxE=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=B4spoGBixlNFzeiQzqwQgfgv52R2FsSxo0hG4wd6BX2Q8WwP8aB1ylkZXL4OpgtA0
	 NfvyRsRARgCwDO1M4H6mQjMQ5TN9H/PlWNC+qn65CMyYgnPvoiHaN14WKpvxutK6Yy
	 G73FTSi0JmztTBORNE2snkoHOnvnMRMLAqnagu+/XZzSVn80ndyhy6HHfvjlzY8Qyu
	 w8qFO+Xfc5s7gR15Ny4mPONYT1x8Xrlw+zYkSceCz/5jG4FuFrzdQAKR/JhEHoinmg
	 N0F6IyCwWKxEyqUnkEYfTq3gr/azJknRH7mhxYDMcf1e91GkhwjC9ZpA0WFTcTNJBR
	 kioAgOsU9MceQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.28;
 helo=out30-28.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=HHLuebPx; dkim-atps=neutral
Received: from out30-28.freemail.mail.aliyun.com
 (out30-28.freemail.mail.aliyun.com [115.124.30.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJFLs5DpKz304C
 for <linux-erofs@lists.ozlabs.org>; Mon, 12 Apr 2021 00:56:36 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08190086|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.113356-0.00592422-0.88072;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04426; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---0UV9r04X_1618152987; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UV9r04X_1618152987) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 11 Apr 2021 22:56:28 +0800
Subject: Re: [PATCH v2] erofs-utils: use qsort() to sort dir->i_subdirs
To: Gao Xiang <xiang@kernel.org>
References: <20210402021741.GB4011659@xiangao.remote.csb>
 <20210405093816.149621-1-sehuww@mail.scut.edu.cn>
 <8f0140a5-c738-7890-eff7-eb877a40035d@aliyun.com>
 <20210411144047.GA15096@hsiangkao-HP-ZHAN-66-Pro-G1>
Message-ID: <eca4aafb-af6b-f31f-67f0-ad59777cb80f@aliyun.com>
Date: Sun, 11 Apr 2021 22:56:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210411144047.GA15096@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2021/4/11 22:41, Gao Xiang wrote:
> Guifu,
> 
> On Sun, Apr 11, 2021 at 10:10:09PM +0800, Li GuiFu via Linux-erofs wrote:
>> Hu Weiwen
>>   It really do a high sort performance increase,
>>   I have a idea that keeping the erofs_prepare_dir_file() function
>> paramter stable, Using a independent function to do dirs sort.
>>
> 
> I think Weiwen's implementation looks fine to me, if you tend to
> not passing nr_subdirs as a cleaner solution, my suggestion would
> be:
> 1) introduce a somewhat erofs_subdirs, which includes
>    - a list_head for all subdir dentries generated from d_alloc;
>    - a nr_subdirs count;
> 2) update erofs_d_alloc to
>    erofs_d_alloc(struct erofs_subdirs *, const char *);
> 3) update erofs_prepare_dir_file to
>    erofs_prepare_dir_file(struct erofs_inode *, struct erofs_subdir *).
> 
> Yet I'd like to apply the current solution first since it helps the
> dir creation performance. If someone has interest to the solution
> above, new cleanup is always welcomed.
> 
> Reviewed-by: Gao Xiang <xiang@kernel.org>
> 

ok, It is also good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
