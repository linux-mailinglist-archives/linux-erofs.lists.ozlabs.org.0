Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7CE311D8C
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Feb 2021 15:02:15 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DXv9c02PqzDwht
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Feb 2021 01:02:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612620132;
	bh=fXANObMK1C4uiBxwfNurwxTBsFxRsEw78kVG/5iQwuw=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=UR7y4Ds+Coi949i9PyyEyGXBEZ+et0hI71FDHYOWABGzElWLcBKdli7/TqVovr9FT
	 FEaf0XtCE53xFgdgJpzmm10AGyqWRuFt9udcp3+4Xi6khKGNdyUnPhUFr8NmVafcKb
	 i0y8j0XAlKuGQQ32EfBkdS2V3fpu0d64OHKAmH6O2FqA54IaTzh+HH9xqZSj8JFmFI
	 D0DtalDojqb/+fNaQGfX4tdZ6RIcG9Er0A9yN/+EeeayIy3UiED7g87M72EAErgpHF
	 f/ygOh1bgXcggZ4clsznpTSJaSftLM7lDJOukkH/bjZNAifhy3G+fm023+WI+BECzF
	 k/v5bjv9RZA0w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.5;
 helo=out30-5.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=KvkiQJrc; dkim-atps=neutral
Received: from out30-5.freemail.mail.aliyun.com
 (out30-5.freemail.mail.aliyun.com [115.124.30.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DXv9M6kbzzDvYp
 for <linux-erofs@lists.ozlabs.org>; Sun,  7 Feb 2021 01:01:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1612620105; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=GOk3c1RJs5UbfDNKc6po2wMTsmjasnzVWVsBWKY96Ws=;
 b=KvkiQJrcrTeCh15RQUynSF0wRO72s+Lrn2y0vYmbXzC32sX92lPXZLqjF56CaxGKiV6wjreG2onuOhy9RZG5Ah7p+kg8acniZXFpdnkOfuWEg8d2qRqX0rce7HuiEGW5vQymaAmA1iy6zuaEMRrfBjVsuMVGa2IcW08UaW2c8qI=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1443566|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00614297-0.00124399-0.992613;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04400; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UO0K2B5_1612619786; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UO0K2B5_1612619786) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 06 Feb 2021 21:56:26 +0800
Subject: Re: [PATCH] erofs-utils: fix mkfs flush inode i_u
To: Hu Weiwen <sehuww@mail.scut.edu.cn>, Gao Xiang <hsiangkao@redhat.com>,
 linux-erofs@lists.ozlabs.org
References: <20210131094525.168251-1-sehuww@mail.scut.edu.cn>
Message-ID: <ec907a7d-ccf8-a5e1-3f34-2249709097cb@aliyun.com>
Date: Sat, 6 Feb 2021 21:56:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210131094525.168251-1-sehuww@mail.scut.edu.cn>
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



On 2021/1/31 17:45, Hu Weiwen wrote:
> When choosing which field of i_u to use, it should be `inode->i_mode & S_IFMT'
> 
> Previously, the default branch is always taken. Fortunately, all 3 field has
> the same data type, and they are in the same union, so it happens to work.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>


It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
