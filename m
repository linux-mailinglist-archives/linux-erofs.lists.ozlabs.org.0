Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05C49FE2E3
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2024 07:14:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YM5Qw6QK3z2yvl
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2024 17:14:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735539255;
	cv=none; b=UkS07Trvi/ry01qYhkfbRrZ+zLqYrmA480oDSimNRHyDTIkNLJc3W1snOpUs06e8PYoPX8wBr1jyZdhTe0DX2xYAuq+d6pGsEIqUWAagajKm1BklmJGRbBx3ur/yIikB+ukc6Tgc5y2/8PY8uj33Ca8O95cexVu1onC//0NP2OBUKf2OHxwIjIvpSPQ4uyjfg3y2gvh1nP/EqBKeAf4XiiQllx95sCqa99Ip+aS6NvlQyaM0m5PdY7AJtoDYtAWbZz4YQBiWe6oi+T1w84PHRGUe/r9C4UzuOT76nCdL417rgUIsHniW5FYtE25O67m5y4TK1N7jhbSdU3B1Zqzzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735539255; c=relaxed/relaxed;
	bh=O3SbhPMxwN/DBEtRCjsSUsZz3vGoC71n8W0P9gHHeQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ou4TpxWeJHif/HzemF841LNDD084l3OYjXY2FKr4U7lf6X5nhlE3pUUXD9iXLyfIUtnoIb6PR2bIpEfA4AWuoTxyL9FxPh6GFj5+SbpZp0RSxp8gZJ3igqnpGC/8P+w4OS0naeOm4++LU8FkuMsEsE9jfYegpbNSZ3aZ1/oI5jg8hFCB8ic1OkrUvIU48q2IyQNOtbD+Jxedvn72ojjQZxGLNR9iQOZkgjhlllMDo9BGpT2peh7fYKpABCFPaK9X3rAFNtq7KOxDdthTa4c/oiha8ZN8AQMGFWBMsT2t/ehEhmVpsuKmz8RYJw0zW/nx26kM6e/LkkntNkEfRJeR2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lhCV9xWS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lhCV9xWS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YM5Qr0rKHz2xDl
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2024 17:14:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735539244; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O3SbhPMxwN/DBEtRCjsSUsZz3vGoC71n8W0P9gHHeQA=;
	b=lhCV9xWSFH8I/wRhpxkS8wWc8GZvfrBvy4vwsyethn+Z8RsUyRUTbAySWtEY83ICYc7UGFybeeDldMG1pBTMTG+VppBprNVxAS/cxGhaxdOXCV8OacSO+M/YSPz3k1Fpa7IsbON7hcKxU/X22GbDxaftEdIXLTx0B3bBN62zvTg=
Received: from 30.41.193.152(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMTFWY9_1735539241 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Dec 2024 14:14:02 +0800
Message-ID: <b46a249f-be06-473a-893e-948d70fec5ee@linux.alibaba.com>
Date: Mon, 30 Dec 2024 14:13:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in erofs_fc_fill_super
To: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 syzbot <syzbot+1379ee6b9a14d5dacaf2@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6770fe12.050a0220.226966.00bb.GAE@google.com>
 <Z3ILF2ClX4sSA0wd@debian>
 <CAKYAXd-wg9dMsv_UgUKVeLCqkFjroh3mBUcywE8mvDcFasjNwA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAKYAXd-wg9dMsv_UgUKVeLCqkFjroh3mBUcywE8mvDcFasjNwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Namjae,

On 2024/12/30 12:33, Namjae Jeon via Linux-erofs wrote:
> On Mon, Dec 30, 2024 at 11:53 AM Gao Xiang <xiang@kernel.org> wrote:
>>
>> Hi exfat maintainers,
> Hi Gao,
> 
> We have a patch for this and will send a PR to Linus soon.
> Thanks!

Many thanks! So good to hear that.  Also (just friendly in
case) it would be helpful to add the following reported-by
to close this syzbot issue..

Anyway, if   addresses at the exfat side:
#syz set subsystems: exfat

Thanks,
Gao Xiang
