Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDC79B140B
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 03:37:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xb2M211l9z3028
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 12:37:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729906620;
	cv=none; b=MuuTRkiu8vUH+dKTOHxJKq3Q083aU0h1BpHpMMvzqi7cE3la5/K4XivpWpmbw+Lm/28Ao5UjdbVdPnWtmQhIiytU3ZiGdQR7Dw0uv4vQJdD+JQJ9eGJls4I+hWK4n13BEWt35L9aFYoaZV+FmYTVidrnK2jC/cJ5AmaN2X3Ubt7HKkwBbd2tFO9t9zhHvFHQUmPwFac0thaVSKsv7zAn8X5ku1+7Tmv1TY3DPWWsZYPgmBkcz83Rn3Xn23lGRneNuroZLgVk5zXH5zO8xUORGtHSIjpW9ASn8fj8nLvzR9w4RkXeqkcTkxvJ9IdcbGBTLP2/Jv2OiLIkHeTsYj/iwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729906620; c=relaxed/relaxed;
	bh=g1JvYbFcAjYILA3Q5uCIqOFluDeLkZCK5pZZEf4IuTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMZit+LBQ4852aog9jxaDxmGz+OBRWjzwCkS4QCARdZC+Zp6YfMrsp0vCDlIvOB6LIRk0Ir0PKkb7qgeq5mFirI8TEAElveGWRWwYzrfY6znUqA1ir8nHyUrVdt7vk1fSlzjdjLWJql+QDHdBpPpajBMAzczmQTY3P8DqIqPivWe3WI76HJ7WDBGqCqA3LdYvrMjVffos2wBCz18MOvAZkSSfB8kWcJ6nX82QKfGTmt72zEj3kAhSDwbbX7cwpNhfPr8qqdZEd11BT+QIQbjTnNnBn0Igb5lnH/eIHbhpJ4LmlpEktT3oDEtJyRpln1g0jHn6qlFs+Q3o65GKcj4+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=awCmVXCM; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=awCmVXCM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xb2Lx5dsJz2xDD
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Oct 2024 12:36:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729906607; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=g1JvYbFcAjYILA3Q5uCIqOFluDeLkZCK5pZZEf4IuTw=;
	b=awCmVXCMwSKH06BkgodtbzqaoLfkAnHM0fN8XjtzSXC8sg5EEh+xSOPkcexObNf6paahzXbDwUa7/1fi8H9RF8+xs12B7gGO1xHrQ8Z/wRVIlA95vb4CuWV3xra2lEw54/sdltAYuB+zPjZn19REzoK8wprhBhUcZBfwYOG2g9U=
Received: from 30.27.69.130(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHtkgup_1729906603 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 26 Oct 2024 09:36:44 +0800
Message-ID: <bfbf180e-21d6-45de-b4c9-43089dcef333@linux.alibaba.com>
Date: Sat, 26 Oct 2024 09:36:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkfs: Fix input offset counting in headerball mode
To: Mike Baynton <mike@mbaynton.com>, linux-erofs@lists.ozlabs.org
References: <20241024195801.1546336-1-mike@mbaynton.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241024195801.1546336-1-mike@mbaynton.com>
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
Cc: sam@posit.co
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Mike,

On 2024/10/25 03:58, Mike Baynton wrote:
> When using --tar=headerball, most files included in the headerball are
> not included in the EROFS image. mkfs.erofs typically exits prematurely,
> having processed non-USTAR blocks as USTAR and believing they are
> end-of-archive markers. (Other failure modes are probably also possible
> if the input stream doesn't look like end-of-archive markers at the
> locations that are being read.)
> 
> This is because we lost correct count of bytes that are read from the
> input stream when in headerball (or ddtaridx) modes. We were assuming that
> in these modes no data would be read following the ustar block, but in
> case of things like PAX headers, lots more data may be read without
> incrementing tar->offset.
> 
> This corrects by always incrementing the offset counter, and then
> decrementing it again in the one case where headerballs differ -
> regular file data blocks are not present.
> 
> Signed-off-by: Mike Baynton <mike@mbaynton.com>

Sorry for late reply, I'm busy in personal stuffs now.
I will look into these cases and reply again later.

Thanks,
Gao Xiang
