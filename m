Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2809C8266
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 06:34:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xppjr49wmz2ytN
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 16:34:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731562447;
	cv=none; b=FYnWm4YJgg0GkRxALXg+8zMzW+vhqEugElFuntjv2IWmDvK340eJNrOJjACdUrbD+9vlga7inNOL/Cj37vx8fdVgm4aXAWRfhxJLCx/xtn9FVT4XZ6JjGPmOhCEWBANbPLojXz0MpgpGlTq/X1vIa3DSgkmYyZ3YwoEsZxbT2sCzLhSjWZq+dgJZL+BJr99mGCYX2ID6gyyLGNN70dIMRyApk0q1p1w78Nn7P9j8JAw8inpCxLgNSjgR9klPqLOL4K6tpKOkUDJvKnuv6GnrUlMr5vwkU1svSJU/tYf7fJBJyFMBAPfgJpjVTW2wsAwMaee/qPzqkKL1ozaSHA5O4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731562447; c=relaxed/relaxed;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JPeokL6iPTu0m7U75yQir9oPLbXIXOy5knYwDdS8yG7LEpHCkkEQx+YTI8SZue9mGv0yyCcf6jrXsnhUe66e51T0mEPbWSkFfl09FO4h6PuuvbGMdfBhD0/OvrqrdI4Jzgpi4kQgPeHHMc7rl9BiWe7Hr969NeaCDpw1Rwic6ZSmYFYV/XiMYEJWGMlX1EEalAw5rClZZ3YxVgOjiTPLo71f4BRyN0i9OuIBkuPWRwBFENrdyGMnOBSB0RaWK0wPgSyQ0CwaAx8WxeT4cDwIdZK0CTX9U+7Cn/gUIBgfkIocBcsjrmEiNXRaa+tLxE1Wm0uJmtxfe51SdS6Y083TbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RpU+zlqY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RpU+zlqY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xppjj4Tb6z2yR9
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 16:33:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731562433; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=RpU+zlqYgQBIrUDjdEkM3O+u99TDzAYtKO7ASYYQe8R1pebtCHWo+iIAkIzB/Q7NDt9yGFkuGa3c0dI5uSLz4pQE9qWEyBj6tSkhRNnPkVERx/pb0e76njATn5vCA2oRJirpcY9cgsYQYBhAri8/APd27K/24qV2Bilzr4sCAsE=
Received: from 30.221.128.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJNGWNH_1731562429 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 13:33:50 +0800
Message-ID: <e22f5b69-0462-41c6-b7a9-b3ae10fa6992@linux.alibaba.com>
Date: Thu, 14 Nov 2024 13:33:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fuse?] general protection fault in fuse_do_readpage
To: syzbot <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
