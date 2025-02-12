Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B84A32A20
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 16:33:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtMlm1XLjz3bjb
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 02:33:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739374403;
	cv=none; b=S+ucSg0+Q764tT5CguOhXstbL8fSTs7gWZMZm1urt8HFtm38VGV2qwwStv45zSkoYXI3+GpDwkhwLrv3DotfF7iaZimPIpRqlXZK9mDBKJhqS/PK6BcCm58PV3g+5GT8T2QdvL6GyD1K1GozsIILotsDI5lP10cII9oMT9YrwM5HiuT7wszIenjzePhqtdyroc3b0WTEJQhxMasfZoTb/NgPPCemF45/Bf69n5vKcUSeonPepVHExBSlGQ5JhZDY3KCORR59iDF4STAiAiBHeTpgGif6SO1KAwCtw0OSxZ66M9SqkmXe5cAjZsdDAlLDjHHqVGvw1tSFHmo7ScKJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739374403; c=relaxed/relaxed;
	bh=XL8IDPZGBf7QrlZ+HcsVFr0MP1RcuEc5LblpFL8S14w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfO+MTBfS5De6G4koSO/1Zf+FXijnUsN3Kiulzw32xaGUwFCWil3Un5uQEZP0Jbai64YyB9H80Cqhlt42qNXxHe8u+jR3W1Wr8He1sVlWAyPs7hh2Ul1C2NE5Z7yXgHz0IT4k3u6a/G2ZyEZti6cMW07kLQ5EPDO0Ct7PGvpEnlKleL8LdnIyZVU5ZcGD5aB2Y7gGEDOG0a/MCad2I6a/W5J6nCMqNuzs/EEOTH54lZ8kA17A4qDPGH5wLgfaTOzDlXCblR3WenpnCCSbigAnGxHF1KaZ0Lsd5TAaxJ7gZmdt2obnGJs53m5Zkd13FIy0D/BnXo5b4Dgx1X1NyDbXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WNOafbPH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WNOafbPH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtMlj2lRGz2ypP
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Feb 2025 02:33:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739374395; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XL8IDPZGBf7QrlZ+HcsVFr0MP1RcuEc5LblpFL8S14w=;
	b=WNOafbPHXu2BxLpanTA/KpEOUFKswKpueJhetKxe9F46ZXd6fn6OKv5xGcrC7/yLm4MHfmSPwxI/IXt7NlGjxbHdD0uXS6oRixrtsGFPi9IMBV2RTarN2CYqQd65Nzfsg/+gNkGfiF4ttkFWmKeKY/6PV7I4JrD0JerFmISjJ9g=
Received: from 30.41.15.245(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPKeHaJ_1739374392 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 23:33:13 +0800
Message-ID: <e16c4550-2a42-40d9-a57a-9be488f89381@linux.alibaba.com>
Date: Wed, 12 Feb 2025 23:33:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/erofs: fix an integer overflow in symlink resolution
To: Jonathan Bar Or <jonathanbaror@gmail.com>
References: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
 <CABMsoEFTGzKhFn7eB0cjg2peCd_DubF-X6Rpq2+1cRVm_J0Q0g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CABMsoEFTGzKhFn7eB0cjg2peCd_DubF-X6Rpq2+1cRVm_J0Q0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org, Tom Rini <trini@konsulko.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/2/12 22:17, Jonathan Bar Or wrote:
> This is good, but may I suggest using __builtin_add_overflow instead?

They are just the same.

erofs-utils follows the kernel style, mostly the kernel doesn't
directly use __builtin_add_overflow, instead it has a wrapper
check_add_overflow().

I could use __builtin_add_overflow for u-boot only.

Thanks,
Gao Xiang

> 
> Jonathan
> 
