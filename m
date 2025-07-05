Return-Path: <linux-erofs+bounces-524-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C68AF9D01
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Jul 2025 02:52:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYsQr2lWcz2ydj;
	Sat,  5 Jul 2025 10:52:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751676724;
	cv=none; b=Q8gnQvvB1ZEpMe3s58MXiUGtV7YYvj+E01pINp4qDV/2VZvYmsPFh5MwrKODZYrye1d5FOkjx4YlETniTpzYqh+rxKekDLngmrNpDvPBgK0nFaqKkyP856FPOCVWczTcvFUS/bdPShIsEoeVv5fwGUne4b8iR5N5xerERGyE/pUW+aUGN50C514qt9rWHHDjxcCenJeaI859+Oo1fhOmfPXdtA1UTOCIVPhMn34hnyqVNhiF/zxAaCBujmjAxX6PBE6jcLJZbAtPrRPsgXib1b7zn93/HuoQ2xu1J/EW1hvg+w6K8Q4basCUP/4p9IZfAPiybzMvlChWVUK7bFkFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751676724; c=relaxed/relaxed;
	bh=PwCQM8e+5fBmkmSW6TJBuWgtD0zVWIsLiKSkSDSg+tU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=GkBx5ym5NHyLLFZkDGa2qQMsbdhDeaxJtA9NcmC01mw3G1IBC71xsD0kjS+OtFMGeVbJTO8zKF3LmjOYV3cS8JfxQ/iJuln2K4fA/tPzjsr2oFA8jeWnP2MJ9R51PXTZAkxbPnOMoMCG7KHnTCVYJIEAJ2WTG9g4YZx7oLRwhL/z3lYSI36itXC+62rneZ7FwvSi9z0xxJ7h9oi2l76yzQrKeW5+ewg0jN6mXH2dCc3l04e0Y8jEDgkTIqqqHhVIDYwLNqIY/msLqI4q/3DiLaCH9OL/d4fhsDNmF6pePz4AFUpbyALAWRX979UiH7yJal8YjzKYARMk/XPOeVSQDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lM0G0oDs; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lM0G0oDs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYsQn4h54z2xHv
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 10:52:00 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751676715; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=PwCQM8e+5fBmkmSW6TJBuWgtD0zVWIsLiKSkSDSg+tU=;
	b=lM0G0oDspZMfYO5+GMbhxrcXaYsd/GC0xOtKhu5agygHMZdbEifBvU/e3Cmr447tYEXTDlYCHMkQIdYL9TiKFtOVIAiVED/oGxlQ6R24JbwT21PN1qJ869KSak9pAda10ef1ry0F8CXPrG11dkahBX38phj5yw8caAfWAysKXQs=
Received: from 30.13.128.169(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WhPQXWH_1751676706 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Jul 2025 08:51:53 +0800
Content-Type: multipart/alternative;
 boundary="------------mWPpIl0l75fZAULUcfM6ibU5"
Message-ID: <3452111b-991f-4be2-8ffd-1172a73feb2e@linux.alibaba.com>
Date: Sat, 5 Jul 2025 08:51:45 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] erofs: allow page cache sharing
To: Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This is a multi-part message in MIME format.
--------------mWPpIl0l75fZAULUcfM6ibU5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/7/3 20:23, Christian Brauner wrote:
> Hey!
>
> This series is originally from Hongzhen. I'm picking it back up because
> support for page cache sharing is pretty important for container and
> service workloads that want to make use of erofs images. The main
> obstacle currently is the inability to share page cache contents between
> different erofs superblocks.
>
> I think the mechanism that Hongzhen came up with is decent and will
> remove one final obstacle.
>
> However, I have not worked in this area in meaningful ways before so to
> an experienced page cache person this might all look like a little kid
> doodling on a piece of paper.
>
> One obvious question mark I have is around mmap. The current
> implementation mimicks what overlayfs is doing and I'm not sure that
> it's correct or even necessary to mimick overlayfs behavior here at all.
>
> Anyway, I would really appreciate the help!

Hi Christian, glad to hear you're interested in my previous patch – and 
please forgive my delayed

response, as I was swamped with other tasks. Finally catching up now 
that it's the weekend. Due to

work change, I can no longer continue driving this patch series upstream.


This patch series seems to be outdated, and some of the implementations 
are quite hacky. Please

take a look at the latest RFC patch series (v6):
https://lore.kernel.org/all/20250301145002.2420830-1-hongzhen@linux.alibaba.com/


> [Background]
> ============
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading identical
> files (e.g., *.so files) from two different minor versions of container
> images will cost multiple copies of the same page cache, since different
> containers have different mount points. Therefore, sharing the page cache
> for files with the same content can save memory.
>
> [Implementation]
> ================
> This introduces the page cache share feature in erofs. During the mkfs
> phase, the file content is hashed and the hash value is stored in the
> `trusted.erofs.fingerprint` extended attribute. Inodes of files with the
> same `trusted.erofs.fingerprint` are mapped to the same anonymous inode
> (indicated by the `ano_inode` field). When a read request occurs, the
> anonymous inode serves as a "container" whose page cache is shared. The
> actual operations involving the iomap are carried out by the original
> inode which is mapped to the anonymous inode.
>
> [Effect]
> ========
> I conducted experiments on two aspects across two different minor versions of
> container images:
>
> 1. reading all files in two different minor versions of container images
>
> 2. run workloads or use the default entrypoint within the containers^[1]
>
> Below is the memory usage for reading all files in two different minor
> versions of container images:
>
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     241     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     872     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     2771    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     926     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     390     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     924     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |     474     |      49%      |
> +-------------------+------------------+-------------+---------------+
>
> Additionally, the table below shows the runtime memory usage of the
> container:
>
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      35     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     149     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     1028    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  1.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     155     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      25     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      98     |      48%      |
> +-------------------+------------------+-------------+---------------+
>
> It can be observed that when reading all the files in the image, the reduced
> memory usage varies from 16% to 49%, depending on the specific image.
> Additionally, the container's runtime memory usage reduction ranges from 10%
> to 48%.
>
> [1] Below are the workload for these images:
> 	- redis: redis-benchmark
> 	- postgres: sysbench
> 	- tensorflow: app.py of tensorflow.python.platform
> 	- mysql: sysbench
> 	- nginx: wrk
> 	- tomcat: default entrypoint
>
> Signed-off-by: Christian Brauner<brauner@kernel.org>
> ---
> Hongzhen Luo (4):
>        erofs: move `struct erofs_anon_fs_type` to super.c
>        erofs: introduce page cache share feature
>        erofs: apply the page cache share feature
>        erofs: introduce .fadvise for page cache share
>
>   fs/erofs/Kconfig           |  10 ++
>   fs/erofs/Makefile          |   1 +
>   fs/erofs/data.c            |  67 +++++++++++
>   fs/erofs/fscache.c         |  13 ---
>   fs/erofs/inode.c           |  15 ++-
>   fs/erofs/internal.h        |  11 ++
>   fs/erofs/pagecache_share.c | 281 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/pagecache_share.h |  22 ++++
>   fs/erofs/super.c           |  62 ++++++++++
>   fs/erofs/zdata.c           |  32 ++++++
>   10 files changed, 500 insertions(+), 14 deletions(-)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250703-work-erofs-pcs-f6f3d0722401
>
--------------mWPpIl0l75fZAULUcfM6ibU5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025/7/3 20:23, Christian Brauner
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org">
      <pre wrap="" class="moz-quote-pre">Hey!

This series is originally from Hongzhen. I'm picking it back up because
support for page cache sharing is pretty important for container and
service workloads that want to make use of erofs images. The main
obstacle currently is the inability to share page cache contents between
different erofs superblocks.

I think the mechanism that Hongzhen came up with is decent and will
remove one final obstacle.

However, I have not worked in this area in meaningful ways before so to
an experienced page cache person this might all look like a little kid
doodling on a piece of paper.

One obvious question mark I have is around mmap. The current
implementation mimicks what overlayfs is doing and I'm not sure that
it's correct or even necessary to mimick overlayfs behavior here at all.

Anyway, I would really appreciate the help!</pre>
    </blockquote>
    <br>
    <p data-spm-anchor-id="idealab.2ef5001f.0.i834.5a4f3d33JHqciL"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">Hi
      Christian, glad to hear you're interested in my previous patch –
      and please forgive my delayed</p>
    <p data-spm-anchor-id="idealab.2ef5001f.0.i834.5a4f3d33JHqciL"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">response,
      as I was swamped with other tasks. Finally catching up now that
      it's the weekend. Due to</p>
    <p data-spm-anchor-id="idealab.2ef5001f.0.i834.5a4f3d33JHqciL"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">work
      change, I can no longer continue driving this patch series
      upstream.</p>
    <p data-spm-anchor-id="idealab.2ef5001f.0.i834.5a4f3d33JHqciL"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;"><br>
    </p>
    <p data-spm-anchor-id="idealab.2ef5001f.0.i834.5a4f3d33JHqciL"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">This
      patch series seems to be outdated, and some of the implementations
      are quite hacky. Please</p>
    <p data-spm-anchor-id="idealab.2ef5001f.0.i834.5a4f3d33JHqciL"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">take
      a look at the latest RFC patch series (v6):<br
style="box-sizing: border-box; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20250301145002.2420830-1-hongzhen@linux.alibaba.com/">https://lore.kernel.org/all/20250301145002.2420830-1-hongzhen@linux.alibaba.com/</a></p>
    <p data-spm-anchor-id="idealab.2ef5001f.0.i834.5a4f3d33JHqciL"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;"><br>
    </p>
    <blockquote type="cite"
      cite="mid:20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org">
      <pre wrap="" class="moz-quote-pre">
[Background]
============
Currently, reading files with different paths (or names) but the same
content will consume multiple copies of the page cache, even if the
content of these page caches is the same. For example, reading identical
files (e.g., *.so files) from two different minor versions of container
images will cost multiple copies of the same page cache, since different
containers have different mount points. Therefore, sharing the page cache
for files with the same content can save memory.

[Implementation]
================
This introduces the page cache share feature in erofs. During the mkfs
phase, the file content is hashed and the hash value is stored in the
`trusted.erofs.fingerprint` extended attribute. Inodes of files with the
same `trusted.erofs.fingerprint` are mapped to the same anonymous inode
(indicated by the `ano_inode` field). When a read request occurs, the
anonymous inode serves as a "container" whose page cache is shared. The
actual operations involving the iomap are carried out by the original
inode which is mapped to the anonymous inode.

[Effect]
========
I conducted experiments on two aspects across two different minor versions of
container images:

1. reading all files in two different minor versions of container images 

2. run workloads or use the default entrypoint within the containers^[1]

Below is the memory usage for reading all files in two different minor
versions of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 &amp; 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 &amp; 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 &amp; 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 &amp; 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 &amp; 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 &amp; 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      35     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 &amp; 7.2.5   |        Yes       |      28     |      20%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     149     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 &amp; 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     1028    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 &amp; 2.11.1  |        Yes       |     930     |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 &amp; 8.0.12  |        Yes       |     132     |      15%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 &amp; 7.2.5   |        Yes       |      20     |      20%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 &amp; 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

It can be observed that when reading all the files in the image, the reduced
memory usage varies from 16% to 49%, depending on the specific image.
Additionally, the container's runtime memory usage reduction ranges from 10%
to 48%.

[1] Below are the workload for these images:
	- redis: redis-benchmark
	- postgres: sysbench
	- tensorflow: app.py of tensorflow.python.platform
	- mysql: sysbench
	- nginx: wrk
	- tomcat: default entrypoint

Signed-off-by: Christian Brauner <a class="moz-txt-link-rfc2396E" href="mailto:brauner@kernel.org">&lt;brauner@kernel.org&gt;</a>
---
Hongzhen Luo (4):
      erofs: move `struct erofs_anon_fs_type` to super.c
      erofs: introduce page cache share feature
      erofs: apply the page cache share feature
      erofs: introduce .fadvise for page cache share

 fs/erofs/Kconfig           |  10 ++
 fs/erofs/Makefile          |   1 +
 fs/erofs/data.c            |  67 +++++++++++
 fs/erofs/fscache.c         |  13 ---
 fs/erofs/inode.c           |  15 ++-
 fs/erofs/internal.h        |  11 ++
 fs/erofs/pagecache_share.c | 281 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  22 ++++
 fs/erofs/super.c           |  62 ++++++++++
 fs/erofs/zdata.c           |  32 ++++++
 10 files changed, 500 insertions(+), 14 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250703-work-erofs-pcs-f6f3d0722401

</pre>
    </blockquote>
  </body>
</html>

--------------mWPpIl0l75fZAULUcfM6ibU5--

