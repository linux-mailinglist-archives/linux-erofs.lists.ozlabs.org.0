Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35459932055
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 08:14:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EkUE/312;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WNTLZ0kSNz3cYx
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 16:14:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EkUE/312;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com; envelope-from=huangzhaoyang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WNTLV1Cxdz30WC
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2024 16:14:40 +1000 (AEST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-52ea929ea56so9521759e87.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jul 2024 23:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721110476; x=1721715276; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Hp32IzbkFzstoqJXLETw7ciCeL12D+J9Ca3PwY99Xc=;
        b=EkUE/312/IP+WxPE3kJCdetYp4buXmoklxUT8R9iaJlovmDNR9DhE0KZzdoD0EJuql
         jnMWf3XzavFP+oeh3WEZ1AJPr7oNCJenR1EmAjRUNR8Ya5NR8vZUA7zFz9Mfm10S/WFc
         EhmSiO/6qVNH9As2WEWgwyhab8WPUxAqkp3YTAKfB9R5Ee7p2LQlzhGMznNj8+gNtuVl
         XKGaXL/9Gw023H9+0TJOP6S/UvMLiJkgB6BFmqRp9RJtyuzFORtl5P0uv7rfW2QWG1eN
         64+Xj7k1Fw3Xn8t+R1ZnHmjZW2H/2YZE/fad36yaKe+LEwfZc4FEmZ/mpqu4L67LyxCw
         wffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721110476; x=1721715276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Hp32IzbkFzstoqJXLETw7ciCeL12D+J9Ca3PwY99Xc=;
        b=oSLYRzCGBzKY+HW+ARCjwEdvYWl7d10+hQlcJw1AJ/m/s4HzsykVyACPnSGTx7KsQZ
         quICiWA+yC2ZpWQtddQdGbRrpeGNG8FBX5vKxr5OUhaCdJtwixv00fK004UanN1VYeNF
         X6zlqQnlR+5fzgluTMo9yUzajiBJ1fIaVkvq7O19K17yCp0dTpbdJEf0NgfWaBlpJgFi
         NnbSDqENdmdk6eW5CKGWEgxA58EI7AECOZwD31mVNfD5Fo55wB2GqzNYbpLJtpCDPHO4
         wcetQ2EE5MgafPaDt0uj6/RPQOPLkxqJzZtOhuUEItHhGpVh1/R7QlQ8djKRgJyTsDkh
         TCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJt3Mb9h0xWNs/MozvOgeBMLAE/L1o3cTPoHv/GHepkR4pw30Bb/+Zq6tFy17MCvmzl4mwI6tICiBFAtNtSNoCqD6dmaQBgedfHSVk
X-Gm-Message-State: AOJu0YwpaPjkM26gR8Jq1k5t2ovZEsW3cp085Cj45WqSIZJP6qmTmVd7
	7UWtNH7+hF0S9FG0Bt6rpH8VJjycZTpBhm7flGzOoL2BIUAqh/b21Yz3hcItGaAGZpx1/+FAZ5/
	x2jb/1riACWj3aVKjwmCy54n1jV8=
X-Google-Smtp-Source: AGHT+IHVkLaBpWdOmqmWX1MjxOwaqCwYYdP7IjrRFHWalMfn5Z88CNTYf8CrIhYyaZTfCn3vZ+LMs5gtphp11Vk8M9E=
X-Received: by 2002:a05:6512:3f06:b0:52c:cb8d:637d with SMTP id
 2adb3069b0e04-52edef0fecbmr859694e87.5.1721110475402; Mon, 15 Jul 2024
 23:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com> <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com>
In-Reply-To: <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 16 Jul 2024 14:14:24 +0800
Message-ID: <CAGWkznEpn0NNTiYL-VYohcmboQ-kTDssiGZyi84BXf5i8+KA-Q@mail.gmail.com>
Subject: Re: [PATCH] fs: fix schedule while atomic caused by gfp of erofs_allocpage
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-kernel@vger.kernel.org, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, steve.kang@unisoc.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 16, 2024 at 1:50=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2024/7/16 13:44, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > scheduling while atomic was reported as below where the schedule_timeou=
t
> > comes from too_many_isolated when doing direct_reclaim. Fix this by
> > masking GFP_DIRECT_RECLAIM from gfp.
> >
> > [  175.610416][  T618] BUG: scheduling while atomic: kworker/u16:6/618/=
0x00000000
> > [  175.643480][  T618] CPU: 2 PID: 618 Comm: kworker/u16:6 Tainted: G
> > [  175.645791][  T618] Workqueue: loop20 loop_workfn
> > [  175.646394][  T618] Call trace:
> > [  175.646785][  T618]  dump_backtrace+0xf4/0x140
> > [  175.647345][  T618]  show_stack+0x20/0x2c
> > [  175.647846][  T618]  dump_stack_lvl+0x60/0x84
> > [  175.648394][  T618]  dump_stack+0x18/0x24
> > [  175.648895][  T618]  __schedule_bug+0x64/0x90
> > [  175.649445][  T618]  __schedule+0x680/0x9b8
> > [  175.649970][  T618]  schedule+0x130/0x1b0
> > [  175.650470][  T618]  schedule_timeout+0xac/0x1d0
> > [  175.651050][  T618]  schedule_timeout_uninterruptible+0x24/0x34
> > [  175.651789][  T618]  __alloc_pages_slowpath+0x8dc/0x121c
> > [  175.652455][  T618]  __alloc_pages+0x294/0x2fc
> > [  175.653011][  T618]  erofs_allocpage+0x48/0x58
> > [  175.653572][  T618]  z_erofs_runqueue+0x314/0x8a4
> > [  175.654161][  T618]  z_erofs_readahead+0x258/0x318
> > [  175.654761][  T618]  read_pages+0x88/0x394
> > [  175.655275][  T618]  page_cache_ra_unbounded+0x1cc/0x23c
> > [  175.655939][  T618]  page_cache_ra_order+0x27c/0x33c
> > [  175.656559][  T618]  ondemand_readahead+0x224/0x334
> > [  175.657169][  T618]  page_cache_async_ra+0x60/0x9c
> > [  175.657767][  T618]  filemap_get_pages+0x19c/0x7cc
> > [  175.658367][  T618]  filemap_read+0xf0/0x484
> > [  175.658901][  T618]  generic_file_read_iter+0x4c/0x15c
> > [  175.659543][  T618]  do_iter_read+0x224/0x348
> > [  175.660100][  T618]  vfs_iter_read+0x24/0x38
> > [  175.660635][  T618]  loop_process_work+0x408/0xa68
> > [  175.661236][  T618]  loop_workfn+0x28/0x34
> > [  175.661751][  T618]  process_scheduled_works+0x254/0x4e8
> > [  175.662417][  T618]  worker_thread+0x24c/0x33c
> > [  175.662974][  T618]  kthread+0x110/0x1b8
> > [  175.663465][  T618]  ret_from_fork+0x10/0x20
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> I don't see why it's an atomic context,
> so this patch is incorrect.
Sorry, I should provide more details. page_cache_ra_unbounded() will
call filemap_invalidate_lock_shared(mapping) to ensure the integrity
of page cache during readahead, which will disable preempt.
>
> Thanks,
> Gao Xiang
