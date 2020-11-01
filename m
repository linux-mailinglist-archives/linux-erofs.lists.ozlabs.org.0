Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3CB2A1E8F
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Nov 2020 15:38:38 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPJZM4F41zDqY3
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 01:38:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604241515;
	bh=WsJC4CwVTgI7HwoKljo5e+m/jbXg9YYPPo2X9yt8XVU=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=B4DU+XaVSxP2TV+zlR03quxSYKj9OQOmYM2Nw4B2q9yw9uOTGGPkS/aOh1mIzDt6R
	 KpxLBzhzqf4I4UiymNXZKor4qnO5wBpgjzpYY9rc2+jXCPoe4gle9mlKifT5WEAnf6
	 R91EtkiU3YWdzwQOyxCbymGU1pNyeZlHZ6v71KBE2J4GcBvnVCKkMVe7VCgFt6n4GX
	 QWmwyMjiv8lS+XXCADAcLrRcgPeo/e3etW2dOM5Tr9NsgSNoi0Ngq7c8qGvhq8bsyk
	 ZR19paRFsHu9PqCIt/5kKxkw/BY/uREMnVFvWQKNzB0ZS1YleOYOsLcyx5P8Zl6WIY
	 bUDfRkLuuKpmQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.38;
 helo=out30-38.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=hVAljx4g; dkim-atps=neutral
Received: from out30-38.freemail.mail.aliyun.com
 (out30-38.freemail.mail.aliyun.com [115.124.30.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPJZD2CTwzDqXQ
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Nov 2020 01:38:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1604241489; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=wiIKmCyRdLxM38Oyq8UxEVFcew5GG+ZLoIx/cYk3Rr0=;
 b=hVAljx4gB0P161DIbISZOb5swhcPjtwkKe0RL8OdkzYnMm0vqDOBbtWFS3hBy1PGAP+nrMlFmpl+GOac0obKEvyplO5SUn9c+3NYKTy7gJlZs6t2jp3z8XvDyl/LVKKBdveP8R7w5uJvt/lDsszn6X2n2cT9hgUgrM/33gsUOxg=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1615965|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00780324-0.000858712-0.991338;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04407; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UDposAJ_1604241488; 
Received: from 192.168.3.18(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UDposAJ_1604241488) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 01 Nov 2020 22:38:08 +0800
Subject: Re: [PATCH 2/4] erofs-utils: support $SOURCE_DATE_EPOCH
To: Gao Xiang <hsiangkao@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20201030123020.133084-1-hsiangkao@redhat.com>
 <20201030123020.133084-2-hsiangkao@redhat.com>
Message-ID: <1e58bbbf-8eda-bbe8-278e-442311cb4457@aliyun.com>
Date: Sun, 1 Nov 2020 22:38:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201030123020.133084-2-hsiangkao@redhat.com>
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



On 2020/10/30 20:30, Gao Xiang wrote:
> Currently, we use -T to set a given UNIX timestamp for all
> files, yet reproducible builds [1] requires what is called
> "timestamp clamping", IOW, a timestamp must be used no later
> than the value of this variable.
> 
> Let's support $SOURCE_DATE_EPOCH as well.
> 
> [1] https://reproducible-builds.org/specs/source-date-epoch/
> Suggested-by: nl6720 <nl6720@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,
