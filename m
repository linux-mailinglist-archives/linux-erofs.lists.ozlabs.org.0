Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3513165DEF
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 13:58:06 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NZQ15ClWzDqSS
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 23:58:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582203481;
	bh=CtXPBKPNqdwFEP0Mq40WCuC+C8dz2SO56UZnyqEXeAo=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GjqrgBWDqoMZTlQNNImVf7YZ4HTXJzDwT13SF44o0lzGMOTAfWHdnIMCseToIFYCl
	 pIOYTPLKroND+Q6fSsyZbOXZoT401KpNzaqfRrLOmyy2IxGLMq8uStzmxowZ+SGBuc
	 /SHg1C9OWOq3GQz7uSxPqHv96qvbUj6RQqDj/zfCSotd6VZRLlM5yFeznVxxvjTFEW
	 AYPZPXVKPwx94jynfBdBdRQZ/xlJZaA9LzoPDzQRwWKw+gYig+zVUzWnSMFgq7TB5F
	 ST3DpqxTPt9i7B+IcYrvSmzYzDwj3LV2exm5iZWAGY+sFZg25rS+HrkNZv4iChsGoY
	 aE0dFIMdQJhEQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.40;
 helo=out30-40.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=KOot/M/T; dkim-atps=neutral
Received: from out30-40.freemail.mail.aliyun.com
 (out30-40.freemail.mail.aliyun.com [115.124.30.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NZPc4CvgzDqSS
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Feb 2020 23:57:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1582203443; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=RLKLSum43ZamcovIDU2DCuTOXwNfereY9Z3qTEOQvzw=;
 b=KOot/M/TzlCFIDeNeM/gXn9qZkSxkRRUc9GMkV18IO55absUwEYYbXx+1JycYf5f6USka2XVvvJHWzAReJ/s3lTrTcgGg8Rct5kV68IqphQL9nfP0CzdpXQMmneMiCiipt+FOXMpX1dxn4A8o1TN8zY0YU7lR/2Lh71EY0BLZoA=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08175699|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.0623414-0.00171365-0.935945;
 DS=CONTINUE|ham_enroll_verification|0.00820447-0.00397167-0.987824;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04400; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---0TqS3nXY_1582203441; 
Received: from 192.168.0.101(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0TqS3nXY_1582203441) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 20 Feb 2020 20:57:22 +0800
Subject: Re: [PATCH v7] erofs-utils: introduce exclude dirs and files
To: Gao Xiang <gaoxiang25@huawei.com>
References: <20200218143047.58488-1-bluce.lee@aliyun.com>
 <20200219022056.GA56477@architecture4>
Message-ID: <4ea1bfc9-9c08-32f3-3c67-c05591be31cb@aliyun.com>
Date: Thu, 20 Feb 2020 20:57:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219022056.GA56477@architecture4>
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
Cc: linux-erofs@lists.ozlabs.org, David Michael <fedora.dm0@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/2/19 10:20, Gao Xiang wrote:
> Hi Guifu,
> 
> On Tue, Feb 18, 2020 at 10:30:47PM +0800, Li Guifu wrote:
>> From: Li GuiFu <bluce.lee@aliyun.com>
>>
>> Add excluded file feature "--exclude-path=" and '--exclude-regex=',
>> which can be used to build EROFS image without some user specific
>> files or dirs. Note that you may give multiple '--exclude-path'
>> or '--exclude-regex' options.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> 
> Applied to experimental branch with the following minor updates.
> 
> If you have more suggestions, please kindly point out. Or I will
> push it out to dev branch later.
> 
> Thanks,
> Gao Xiang
> 
 It looks good
