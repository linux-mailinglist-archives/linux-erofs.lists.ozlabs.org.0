Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 140B499E2B5
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 11:23:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSTD84XHQz3bqD
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 20:23:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728984199;
	cv=none; b=Yy+tzO3FHTb9Nk0K1BUtlieXcS5nmEeKQbzupka93yy5iF1+LmCseTjxcu4EqnvJgqkUduPIcwKkz0DnQP0s/GH4jJRxp2KhNDSqm0Tlg8/sl87d93GBYmzG1hxLjtRkIxqQwev6W5ijJ+o9i3Z/VdIh52xWUdcEWo6Inb9odayy9FtParav+UnkdSUOBjnYRDmf+s+8vgd0C3kOf2rdGhHhGQ1smrCw0ogTjT+3RVsAx+dt1QZz9ppocrSQXwhtF1tY3+MXQBuLS6QBD4Y0PF//+g3nXi7hwnZZVmNmtlWyvAZU/SsSNOqveB3RPbgJaPStIOu9j9sADXV4zznfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728984199; c=relaxed/relaxed;
	bh=thvKDbHAVI3x7P3AOF8YpfHXmW9FfZUNQ8Uvg2B8yAE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IXSIYd8mBb/wUgIF6Dx4DFVZijam2dWJJzsw/zteZBx0UdF2hNiiWNjNTV8XunBZa61kErteK6eGgZrJmKjYN0B+jIMxNAez1A9ZVkZ4/B/YK8mOmicvSXSO4fWJfpe1igRHC5ZFyJo/pXsHH2fR0hO9afBhQbs8/DTs3740rQmDvWQDLSlGxOR5w30Zct0TAU5KZVaaPI+bGXrkhhUiWON5L47TYflU3QPk4QkNcuRznmKETRKRc2+12nW5ikT0wgUWfQatnL1OjHdy9U6T//Yw+owS/E0kV4a8Hpz+RFfOQs98PqM17FXE2R/9Q/M5SYcA08AtYj4xpqskoeBfAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TO55TnGL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TO55TnGL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSTD11lwkz3bkL
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 20:23:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728984184; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=thvKDbHAVI3x7P3AOF8YpfHXmW9FfZUNQ8Uvg2B8yAE=;
	b=TO55TnGLDZzFSRzQNivoD1flDnfRKHQFKuA2ZWK844054/y7+AXHO9ouJMUcjYXy8jNUGy7t6D0kBDVyTHmKTUiHfveJx8vQIwsEDw3+tks/CrW2Cf8Ue+2MqO5dNSsyEymWgGW1jJH9jhJ3bHCsCtDU1WlPPg/DzSJaUVXB7bE=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHD3Y7g_1728984182 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 17:23:03 +0800
Message-ID: <d38ebf68-46c7-443a-8771-3dbd835a17fd@linux.alibaba.com>
Date: Tue, 15 Oct 2024 17:23:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Gao Xiang <xiang@kernel.org>
References: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
 <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
In-Reply-To: <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20241014
