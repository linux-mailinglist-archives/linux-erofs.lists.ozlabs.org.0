Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583A620740
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 04:06:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N5tKr06Flz3cJL
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 14:06:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=acKb8tRh;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=acKb8tRh;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N5tKj42ZDz3bj0
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Nov 2022 14:06:33 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F3CB1612E1;
	Tue,  8 Nov 2022 03:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBE1C433D6;
	Tue,  8 Nov 2022 03:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667876788;
	bh=QF78iOGcajcnk4Z9GZuE7IjkV7FmrSLX0pW9ceH+Kl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=acKb8tRhXB8nu+hrly0zCkR3DiQc2b3rI9oVBOwQ4FMxtJEgKciwbkKRbY9sE2A1t
	 tY9A5NF5vey63bOrykf001ThaeMyLjXuJKRbF5dysP+j8t4OVZqM5yr+JxqSmTUvZ7
	 WluwTKS0iJEAlINpIOyRVuIT7xFAw4L+x5WTKMosIBFdyVWGkMcwtuSL6lpoad2ZQW
	 I55lCvkZDzrs/BlvIbPTbjBQ98fI4Ra5A2ibDaqUOyD/82dMHkJ5MoJi+UStjkYazl
	 mD8iEEfkceGTh2hoR9c+CNQe24T4zqxqSI7fIGnwk54W+MY7dozCbJiT6hKdX1a1yi
	 fOVmfYfwjbvNw==
Message-ID: <dd8c717a-28d7-f155-d5ee-24e8f28c4329@kernel.org>
Date: Tue, 8 Nov 2022 11:06:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] erofs: fix general protection fault when reading
 fragment
Content-Language: en-US
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org
References: <20221021085325.25788-1-zbestahu@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221021085325.25788-1-zbestahu@gmail.com>
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
Cc: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/10/21 16:53, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> As syzbot reported [1], the fragment feature sb flag is not set, so
> packed_inode != NULL needs to be checked in z_erofs_read_fragment().
> 
> [1] https://lore.kernel.org/all/0000000000002e7a8905eb841ddd@google.com/
> 
> Reported-by: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com
> Fixes: 08a0c9ef3e7e ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
