Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5708E99E305
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 11:47:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSTlS1dnDz3bpm
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 20:47:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728985617;
	cv=none; b=ChAuMaYEwApFuIVt8Z2wWlkbzEWwrxSOiv1k0UttYIPFV5iFuwK/dzNviAYJLnbuVfYjwIfqmsewKRE19IqonH8kxVzvGRdYI8W2IJC1/OsRhmlJx9z+fjeOjYBb1m5tyjMkcCn0m3IGj0wuqrTz0UCDUS4l3FHNAiNkQ3DQHjFvMIGOf/qy3RCxeXu/uHeqFu7zW0oYGEBA1N9sxDGUwToi7aZZASs3G6K5Scusx1MH1hjLa4Uy8gv8/7FxgLCw6F1l+3MS38PfBaz+16puAIYh5SSrhaLfArYIT2lJDUNTD/D6A7hgmQ+2dwhUsV700ABlxTKuIPaiMUW+SFBR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728985617; c=relaxed/relaxed;
	bh=lUDOiYXC1OtSoLrZWAkKNcP23YcMApgq7JF0NZ2HrtY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=NZ0zxrtFUrshYT+bQOf0HJ8IQEriNnXBRNs7U/th/OtwXgaJXcK69Ef7ClhlBESJMKJ53kjIQr4mKNXrGkXmcSFuxZLz2k1ZSHe0MmayIKlIsjzzWGm9qTgy9A3zpYkeuqhHIs2pufDi4+Gk9uSin+JI9XBek3ppFaNkLSbh7gj0DXhkpGqd/69HdlNMl8TnZ5bHM0fMV962rovSN85b/wcPfRG1wcewYXSPhgye3qyZVFyWMankP8t1iQQhIppgWq4IhQ39m22GhJHsYLaCH+LuZ6GvPIYoSbvVg4ANGRAHGTa7f6NCfvEK+f2gG2nHVNSLdo3LztajONi+10G/Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OMakYtPW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OMakYtPW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSTlL42Vxz2yRF
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 20:46:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728985608; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=lUDOiYXC1OtSoLrZWAkKNcP23YcMApgq7JF0NZ2HrtY=;
	b=OMakYtPWpqEiyBQT2zI2oD/wEiBwsnu6gosEqwv+E5JCxpanoGkE8dpbSdu4t5s5vTAI6xVaX1zBgMBAM9fpG74zFbPE984x0ebmDzPvNHpvluwRjGBVcwlNax2V2phL1AmWGDagDa/hHvgN/v4T+uNxGS6XP7TvaYp3m+Q1UKg=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHDE26t_1728985606 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 17:46:47 +0800
Message-ID: <120ff6bf-3607-4f6b-9ec4-f1af9bdbdbd0@linux.alibaba.com>
Date: Tue, 15 Oct 2024 17:46:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
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

another one:
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git erofs-for-6.12-rc4-fixes
