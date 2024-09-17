Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7317597AB85
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 08:39:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7Bvl0DTQz2yMt
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 16:39:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726555152;
	cv=none; b=m3t4R5/j0NWvxGkHsxF2JsAVWuidREN4ZCbjCQ2SYbqOZaelRWfi0u/AQgfzqBWwL6F3MxiDTI+3jRyYskiyGGpjtiVJF9+RXF1dNeHbY5R0hX9edY0B4DsugAuRM6+ySWwuJ2IloPlGPNNgnwF5A9BLSEwjMHU0Uaii2/ouwfJvtLcVS01LDm0bs/9Kmbt5CrpRUI4nXR8W8xmq41djLNmLFVs/qMw9IbjZLWfWwCYsYK8Uryar04oxi9o/ZLBBLtlC/qs6t1xx8zN4yHGPaQedRr+CNn5/nsJ2XgClMDBpXncTA96R08aeZ5DZjvAz5KRXTKeW7HjDs0p/rj24dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726555152; c=relaxed/relaxed;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PDh4rabp2RAIvw+1KYwBGTyFIylViAm8RQcxlMR47zpXGbt8qhLEj3e5D3pKYxS3hsZjAwAX0xAM/ZKsIrEHlajyjuSlNEspydkUOzmHxyUNRxDKWTRvj9EuP4oeohjAQZZ2GOaVBDCoxhAVf/dGzFyy1yrhR9LjaTElwk0berklKEeG4yIR48bSJiBVypTeLhf5Y5jOYpR6BKAoxL8soC9Rfy3zydoGG/fabIej5E/IYin220ZKIaCy6L0NhOtvFBFp/862ft+tytYt0Xa8c5Uz+i4oIB00xCI5p7eT8zwDVZPzYMRWl27+eOEz6ociOfdXeV/c4LckOoDh4N6w3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G1j+R7LH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G1j+R7LH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7Bvd39ngz2xLR
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 16:39:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726555144; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=G1j+R7LHxQ7sH8VEPCWl0dgSIshbHXkBZBEJDptGjyODZH2AE9vvgpHA9tZNVXVpN+gfeOBkocfCSDEIAkK4cDST9wqdBPFenHVxmQOCQdNY+OSBpG0nDP0bm5WwHwu9hTJfEv5qJ3zPDymY/czgWKDM9c7L8BRWGdxzO8HTg1Y=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFA9uEv_1726555141)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 14:39:03 +0800
Message-ID: <f58a6956-5029-4764-962c-ffc02602a755@linux.alibaba.com>
Date: Tue, 17 Sep 2024 14:39:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in filemap_read_folio (3)
To: syzbot <syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <00000000000011bdde0622498ee3@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <00000000000011bdde0622498ee3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
