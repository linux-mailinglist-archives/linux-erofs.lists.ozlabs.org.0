Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D883C2BBD88
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 07:35:20 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdNvT468GzDr0f
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 17:35:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605940517;
	bh=AHsZOMZkXBhIH7JZ8jNgZkK95qJ/WNnLDa9m2+P4bnQ=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=c0ijRPxT5FBj1zyYYkV+CtCHMhEqBh3OqcxeHc57J7hGoNvKQ01KPETCOu2T21kVn
	 GvTkH39oANdAv9KVaE7bz5bSWC8XUGaAF8XCc9YQrfpO2wstbHXA8yZtNQWCQXOhoi
	 ulRMDyX3B+UPbwU8w3OICU26opoF48+hPoTjSAJqZP79vJJFwaj9j4d7xsD/e/TIfJ
	 9kc6NeI/rd2xLWvHOjDmLM0/RyXi6KzFJ3qOI4nfsd7KMq1ypd50Jn23Xk+qf1c71e
	 oL4qjsBKmzGERt7mqPbX9ApsO6VPn1OgVE3XiKQpfwT/DiHFdCH7w5do5IuR8sWWdn
	 DVeoFiwDu5zZw==
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
 header.s=s1024 header.b=Jvz0Pym/; dkim-atps=neutral
Received: from out30-4.freemail.mail.aliyun.com
 (out30-4.freemail.mail.aliyun.com [115.124.30.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdNvM65qRzDqwm
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 17:35:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1605940498; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=LZj1EK6QUSpMSTzmc7xVvHm18jS2kb2Mihajo95bfQw=;
 b=Jvz0Pym//YYFAkfTDT+H3Fs6KintCnC1XdXr4Bfk9eU4/0WIjDutBaOcwXzJg1m/0v9Znl32tSNZCdMrJ0b0PoSEoIYXyDOaQDlTP33qbgn4OOni+ckpgS56sfURCszYHV6lxCppGqmpTTL12YpVnyyz2hWOe0jhZQABnVeIbhw=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1964222|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.00474909-0.000776753-0.994474;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04420; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UG1TWol_1605940498; 
Received: from 192.168.3.30(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UG1TWol_1605940498) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 21 Nov 2020 14:34:58 +0800
Subject: Re: [PATCH v3 2/2] erofs-utils: update README
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201121022623.3882-1-hsiangkao@aol.com>
 <20201121022623.3882-2-hsiangkao@aol.com>
Message-ID: <794ee690-5fe2-6078-d09d-351d603973e6@aliyun.com>
Date: Sat, 21 Nov 2020 14:34:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201121022623.3882-2-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2020/11/21 10:26, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> Make it easier to understand...
> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
