Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B351A16530
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 02:45:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YbtT26mGzz300V
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 12:45:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737337525;
	cv=none; b=HaeLN4KtJaw/KKB5QfVmFtyEhy/Y/fuSnz9o7cS5af4QZGAHz6z3qYtQP8cI6BZZ4boF9yYi/EhRbUKILhkEQxyLZuDVMgO/PVhV656+K5kdY3CvWl4epVHghRRrb5AWu7m2ksuqAOjpyk2gw9g7AAhCelT1K5Mk+sAEwmZ6l73HEVInlJryvWBe6vghpz9GhxiMscfvvXj0oAEwl4UvpmKFWNnWmyQE/Ib//MklZ4lkVkgHCEPTi5i6b62vp77Me70MdrMFTPea2iuHtCfxJhxjCgihclBuuDm+DenHSTTNKMlIlnEHVmhJTvn+ZeOK3xDRrLKrXOxMPQMObSISVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737337525; c=relaxed/relaxed;
	bh=yRCMMvRkZiWwbIL1ASmyeSv1g7dQqLQpguPo3IGLCo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PV8UOvbPqvavDR439xKgjMfhhSkNiMmFVxVsnqjtU9yzlktUgO26RQwDIlm9BdtqZ2vAPXw4hw5qk5ux9dfkFRZ/k+vl1dpiRCNb1cBS9Yd6Eh3S2iQwmiGNlEeG3Aclz4NLgHx6LD7tMMqT6aSLMVlcjc0O8aUzcMx0jixDjasKL7QPNpWXdin0xS87CplvR96yoejjD31Xsw6ajm5bTesuWKZ7zOp1Yls5u8edZDdbiFEKF4XLb/+Hl9aWBmYtO73lhB+hmpeo3OLvOxuxU34sVwnPgJtZvAb/Q2s9dFVUh1gkx+YuYusM01xFmK4O6wS/WGosVKmAQczB9BcDKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BeZs6Pur; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BeZs6Pur;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YbtSy5G4Bz2xxx
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 12:45:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737337516; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yRCMMvRkZiWwbIL1ASmyeSv1g7dQqLQpguPo3IGLCo0=;
	b=BeZs6PurDUPnSrnvR4q/TG3b62aRPE59gBvQUn/QP/iW7c+q6Cf8ykvZE7RpRTUEH+Gv/YiHCbB8TtQztroT4Vx+2YK2YctWA0u0wBi3oCyUUdgCVKciG6it5xI/soXCT6UV62/x3LfclZMbK/chY4SsABoXOvU6CsKwPsrHRQY=
Received: from 30.221.129.118(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNv9NO2_1737337513 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 09:45:14 +0800
Message-ID: <b73823e2-a976-4831-90c7-405316440236@linux.alibaba.com>
Date: Mon, 20 Jan 2025 09:45:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] data corruption of init process
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>, linux-erofs@lists.ozlabs.org
References: <c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de>
 <14b78097-ee6a-4e91-9688-172ce807299b@linux.alibaba.com>
 <1ee54399-88ef-440e-9262-cba0bcc28c90@pengutronix.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1ee54399-88ef-440e-9262-cba0bcc28c90@pengutronix.de>
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

Hi Stefan,

On 2025/1/19 20:07, Stefan Kerkmann wrote:

...

> 
> Here is the new output:
> 
> BAD:
> 
> [    4.775107] erofs: (device mmcblk3p3): mounted with root inode @ nid 36.
> [    4.782154] VFS: Mounted root (erofs filesystem) readonly on device 179:3.
> [    4.789277] devtmpfs: mounted
> [    4.802482] Freeing unused kernel image (initmem) memory: 1024K
> [    4.809163] Run /sbin/init as init process
> [    4.813358]   with arguments:
> [    4.816516]     /sbin/init
> [    4.819387]   with environment:
> [    4.822621]     HOME=/
> [    4.825068]     TERM=linux
> [    4.836923] vfs_open: /usr/lib/systemd/systemd
> [    4.843463] erofs: (device mmcblk3p3): lz4        : src c1002000 dst: c1000000 in: 4096b (eec708e7, bf5f1f80, 2) out: 8859b (3bfdda11)
> [    4.855839] erofs: bf5f1fc0 i_ino 868416, index 0 dst 810fe000 (7795d697)
> [    4.862916] erofs: bf5f1fa0 i_ino 868416, index 1 dst 810fd000 (e09f25c3)
> [    4.876706] erofs: (device mmcblk3p3): lz4        : src c1005000 dst: c100429b in: 4096b (76037b0d, bf5f1f60, 3) out: 5168b (79840434)
> [    4.889190] erofs: bf5f1f80 i_ino 868416, index 2 dst 810fc000 (88265a45)
> [    4.896188] erofs: (device mmcblk3p3): lz4 partial: src 82a06000 dst: 810fb6cb in: 4096b (45bf72c3, bf6240c0, 6462) out: 2357b (6e052dd5)
> [    4.908893] erofs: bf5f1f60 i_ino 868416, index 3 dst 810fb000 (2b4319d2)
> [    4.916986] vfs_open: /usr/lib/ld-linux-armhf.so.3
> [    4.923494] erofs: (device mmcblk3p3): lz4        : src c1007000 dst: c1006000 in: 4096b (e4b39a2, bf5f1f20, 1) out: 4907b (aa05f0a3)
> [    4.935773] erofs: bf5f1f40 i_ino 190291, index 0 dst 810fa000 (20419a5e)
> [    4.942887] erofs: (device mmcblk3p3): lz4        : src c1009000 dst: c100832b in: 4096b (717fc925, bf5f1f00, 2) out: 4246b (c0f62dca)
> [    4.955958] erofs: (device mmcblk3p3): lz4        : src 82a06000 dst: c100a6cb in: 4096b (45bf72c3, bf6240c0, 6462) out: 6376b (dfcc8264)
> [    4.968686] erofs: bf5f1f20 i_ino 190291, index 1 dst 810f9000 (64eb9a49)
> [    4.975837] erofs: (device mmcblk3p3): lz4        : src c100d000 dst: c100c3c1 in: 4096b (8030d189, bf5f1ee0, 3) out: 4292b (1df48c5f)
> [    4.989972] erofs: bf5f1f00 i_ino 190291, index 2 dst 810f8000 (7fc63af4)
> [    4.997061] erofs: (device mmcblk3p3): lz4 partial: src 82a09000 dst: 810f7485 in: 4096b (17ce8f99, bf624120, 1493) out: 2939b (a1ab12cf)
> [    5.009760] erofs: bf5f1ee0 i_ino 190291, index 3 dst 810f7000 (285ac58c)
> [    5.018572] erofs: (device mmcblk3p3): lz4        : src c1010000 dst: c100efb3 in: 4096b (74af795c, bf5f1e60, 6) out: 4651b (46c58dd7)
> [    5.030944] erofs: bf5f1ea0 i_ino 868416, index 4 dst 810f5000 (7ce0249e)
> [    5.038011] erofs: bf5f1e80 i_ino 868416, index 5 dst 810f4000 (d832cf73)
> [    5.045140] erofs: (device mmcblk3p3): lz4        : src c1013000 dst: c10121de in: 4096b (d65a3a49, bf5f1e40, 7) out: 5360b (4364e0fc)
> [    5.057710] erofs: bf5f1e60 i_ino 868416, index 6 dst 810f3000 (aa9da9e7)
> [    5.064783] erofs: (device mmcblk3p3): lz4        : src c1015000 dst: c10146ce in: 4096b (db73bb75, bf5f1e20, 8) out: 4606b (c0a54f50)
> [    5.077215] erofs: bf5f1e40 i_ino 868416, index 7 dst 810f2000 (372b935)
> [    5.084331] erofs: (device mmcblk3p3): lz4        : src c1017000 dst: c10168cc in: 4096b (be653c3d, bf5f1e00, 9) out: 4536b (10b3a4d0)
> [    5.096680] erofs: bf5f1e20 i_ino 868416, index 8 dst 810f1000 (3ebcefe7)
> [    5.103844] erofs: (device mmcblk3p3): lz4        : src c1019000 dst: c1018a84 in: 4096b (8cd3cff3, bf5f1de0, 10) out: 4285b (541c02fb)
> [    5.116288] erofs: bf5f1e00 i_ino 868416, index 9 dst 810f0000 (12adb98e)
> [    5.123384] erofs: (device mmcblk3p3): lz4        : src c101b000 dst: c101ab41 in: 4096b (b885e4f7, bf5f1dc0, 11) out: 4789b (af1820d3)
> [    5.135910] erofs: bf5f1de0 i_ino 868416, index 10 dst 810ef000 (e8b33507)
> [    5.151679] erofs: (device mmcblk3p3): lz4        : src c101e000 dst: c101cdf6 in: 4096b (3b4e9357, bf5f1d80, 13) out: 6216b (6a149c5)
> [    5.164054] erofs: bf5f1dc0 i_ino 868416, index 11 dst 810ee000 (72cdfbb)
> [    5.171019] erofs: bf5f1da0 i_ino 868416, index 12 dst 810ed000 (a4856fd6)
> [    5.178261] erofs: (device mmcblk3p3): lz4        : src c1022000 dst: c102063e in: 4096b (a3bdbd0e, bf5f1d40, 15) out: 8015b (63d1fbc1)
> [    5.190688] erofs: bf5f1d80 i_ino 868416, index 13 dst 810ec000 (d027d81e)
> [    5.197815] erofs: bf5f1d60 i_ino 868416, index 14 dst 810eb000 (307b732a)
> [    5.204989] erofs: (device mmcblk3p3): lz4        : src c1025000 dst: c102458d in: 4096b (480285a7, bf5f1d20, 16) out: 6603b (822f8de0)
> [    5.217425] erofs: bf5f1d40 i_ino 868416, index 15 dst 810ea000 (39882425)
> [    5.224569] erofs: (device mmcblk3p3): lz4        : src c0b49000 dst: c1026f58 in: 1839b (4f637f42, bf5f1d00, 17) out: 5780b (55fe911f)
> [    5.237007] erofs: bf5f1d20 i_ino 868416, index 16 dst 810e9000 (7f303847)
> [    5.244123] erofs: bf5f1d00 i_ino 868416, index 17 dst 810e8000 (7e903556)
> [    5.251188] erofs: bf5f1ce0 i_ino 868416, index 18 dst 810e7000 (e3449d72)
> [    5.266482] erofs: (device mmcblk3p3): lz4        : src 82a0c000 dst: c102acc6 in: 4096b (cd2f4c7c, bf624180, 1502) out: 4175b (3bf4f1a9)
> [    5.279204] erofs: (device mmcblk3p3): lz4        : src c102d000 dst: c102cd15 in: 4096b (8e87c14d, bf5f1c80, 14) out: 4288b (6a251e64)
> [    5.291669] erofs: bf5f1ca0 i_ino 190291, index 13 dst 810e5000 (36a0d885)
> [    5.298823] erofs: (device mmcblk3p3): lz4        : src c102f000 dst: c102edd5 in: 4096b (31a2e179, bf5f1c60, 15) out: 4257b (3e19e451)
> [    5.311318] erofs: bf5f1c80 i_ino 190291, index 14 dst 810e4000 (8890a118)
> [    5.318495] erofs: (device mmcblk3p3): lz4        : src c0b49000 dst: c1030e76 in: 4096b (65fa2fbe, bf5f1c40, 16) out: 4460b (ebe0126c)
> [    5.330928] erofs: bf5f1c60 i_ino 190291, index 15 dst 810e3000 (d48cbaf9)
> [    5.338140] erofs: (device mmcblk3p3): lz4        : src c1034000 dst: c1032fe2 in: 4096b (37a8bad1, bf5f1c00, 18) out: 4349b (c125197)
> [    5.350495] erofs: bf5f1c40 i_ino 190291, index 16 dst 810e2000 (940857ad)
> [    5.357609] erofs: bf5f1c20 i_ino 190291, index 17 dst 810e1000 (bd0e7a43)
> [    5.364718] erofs: (device mmcblk3p3): lz4        : src c1037000 dst: c10360df in: 4096b (8d172a42, bf5f1be0, 19) out: 4353b (1503ff28)
> [    5.377148] erofs: bf5f1c00 i_ino 190291, index 18 dst 810e0000 (dec8eb5c)
> [    5.384381] erofs: (device mmcblk3p3): lz4        : src c1039000 dst: c10381e0 in: 4096b (1ef07e2b, bf5f1bc0, 20) out: 4869b (c3bf758b)
> [    5.396811] erofs: bf5f1be0 i_ino 190291, index 19 dst 810df000 (6e7792a7)
> [    5.404048] erofs: (device mmcblk3p3): lz4        : src c103b000 dst: c103a4e5 in: 4096b (f4462dc1, bf5f1ba0, 21) out: 5484b (9b35c90f)
> [    5.416471] erofs: bf5f1bc0 i_ino 190291, index 20 dst 810de000 (97b42709)
> [    5.423664] erofs: (device mmcblk3p3): lz4        : src c103e000 dst: c103ca51 in: 4096b (2ac6b4d5, bf5f1b60, 23) out: 5985b (94cc0d29)
> [    5.436100] erofs: bf5f1ba0 i_ino 190291, index 21 dst 810dd000 (29751a32)
> [    5.443212] erofs: bf5f1b80 i_ino 190291, index 22 dst 810dc000 (eeea8a30)
> [    5.450468] erofs: (device mmcblk3p3): lz4        : src c1041000 dst: c10401b2 in: 4096b (90757c3c, bf5f1b40, 24) out: 6356b (58df129b)
> [    5.462902] erofs: bf5f1b60 i_ino 190291, index 23 dst 810db000 (a86b83ad)
> [    5.470092] erofs: (device mmcblk3p3): lz4        : src c1044000 dst: c1042a86 in: 4096b (971b791e, bf5f1b00, 26) out: 6045b (3a6bbefa)
> [    5.482526] erofs: bf5f1b40 i_ino 190291, index 24 dst 810da000 (2535a069)
> [    5.489658] erofs: bf5f1b20 i_ino 190291, index 25 dst 810d9000 (98287e49)
> [    5.496972] erofs: (device mmcblk3p3): lz4        : src c1048000 dst: c1046223 in: 4096b (9804bc65, bf5f1ac0, 28) out: 10510b (2a60a723)
> [    5.509790] erofs: bf5f1b00 i_ino 190291, index 26 dst 810d8000 (64b12fc2)
> [    5.516825] erofs: bf5f1ae0 i_ino 190291, index 27 dst 810d7000 (de4b4264)
> [    5.524296] erofs: (device mmcblk3p3): lz4        : src 82a0da35 dst: c104ab31 in: 1483b (5c99618c, bf6241a0, 0) out: 4759b (b53e5caa)
> [    5.540762] erofs: bf5f1ac0 i_ino 190291, index 28 dst 810d6000 (7881835d)
> [    5.547904] erofs: bf5f1aa0 i_ino 190291, index 29 dst 810d5000 (80d1e247)
> [    5.555492] erofs: (device mmcblk3p3): lz4        : src 82a09000 dst: c104c485 in: 4096b (17ce8f99, bf624120, 1493) out: 4289b (7dbbff69)
> [    5.568341] erofs: (device mmcblk3p3): lz4 partial: src 82a0c000 dst: 810cacc6 in: 4096b (cd2f4c7c, bf624180, 1502) out: 826b (21762da4)
> [    5.586697] erofs: (device mmcblk3p3): lz4        : src c104f000 dst: c104e546 in: 4096b (e286b2b, bf5f1a20, 5) out: 4207b (ec8e3f58)
> [    5.599002] erofs: bf5f1a40 i_ino 190291, index 4 dst 810d2000 (63f2218c)
> [    5.606110] erofs: (device mmcblk3p3): lz4        : src c1051000 dst: c10505b5 in: 4096b (e698fd35, bf5f1a00, 6) out: 4291b (fcf580f8)
> [    5.618467] erofs: bf5f1a20 i_ino 190291, index 5 dst 810d1000 (d2cc83a9)
> [    5.625492] erofs: (device mmcblk3p3): lz4        : src c1053000 dst: c1052678 in: 4096b (4859aa8f, bf5f19e0, 7) out: 4297b (ab8a8574)
> [    5.637839] erofs: bf5f1a00 i_ino 190291, index 6 dst 810d0000 (fe13cf51)
> [    5.644932] erofs: (device mmcblk3p3): lz4        : src c1055000 dst: c1054741 in: 4096b (997436a4, bf5f19c0, 8) out: 4218b (be0817b8)
> [    5.657267] erofs: bf5f19e0 i_ino 190291, index 7 dst 810cf000 (a4994a5f)
> [    5.664382] erofs: (device mmcblk3p3): lz4        : src c1057000 dst: c10567bb in: 4096b (112a3fda, bf5f19a0, 9) out: 4271b (293ce253)
> [    5.676718] erofs: bf5f19c0 i_ino 190291, index 8 dst 810ce000 (9e8ba792)
> [    5.683777] erofs: (device mmcblk3p3): lz4        : src c1059000 dst: c105886a in: 4096b (fa3410b9, bf5f1980, 10) out: 4673b (7f7a9871)
> [    5.696214] erofs: bf5f19a0 i_ino 190291, index 9 dst 810cd000 (902d97fe)
> [    5.703322] erofs: (device mmcblk3p3): lz4        : src c105b000 dst: c105aaab in: 4096b (634b03ca, bf5f1960, 11) out: 4477b (cf289eb)
> [    5.715669] erofs: bf5f1980 i_ino 190291, index 10 dst 810cc000 (60b7ab45)
> [    5.722863] erofs: (device mmcblk3p3): lz4        : src 829b3000 dst: c105cc28 in: 4096b (163cdf49, bf623660, 0) out: 4254b (998b1f98)
> [    5.735217] erofs: bf5f1960 i_ino 190291, index 11 dst 810cb000 (55814486)
> [    5.742263] erofs: bf5f1940 i_ino 190291, index 12 dst 810ca000 (717aa17d)
> [    5.749414] 8<--- cut here ---
> [    5.752564] init: unhandled page fault (11) at 0x6f842180, code 0x005
> [    5.759492] [6f842180] *pgd=00000000
> [    5.763255] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.12.10-00011-gaa53ac55e70a #110
> [    5.771605] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    5.778371] PC is at 0x76f8dc86
> [    5.781680] LR is at 0x76f942a5
> [    5.784982] pc : [<76f8dc86>]    lr : [<76f942a5>]    psr: 20001430
> [    5.791444] sp : 7e944e68  ip : 76fa2000  fp : 00000016
> [    5.796759] r10: 76f84000  r9 : 76fa25f0  r8 : 76fa1ce0
> [    5.802193] r7 : 7e944e80  r6 : 76fa2000  r5 : 00000003  r4 : 76f84148
> [    5.808887] r3 : 00000008  r2 : 6f842180  r1 : 00000001  r0 : 76fa25f0
> [    5.815601] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA Thumb  Segment user
> [    5.823117] Control: 50c5387d  Table: 1369c04a  DAC: 00000055
> [    5.829086] Call trace:
> [    5.829153] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    5.839600] Dumping ftrace buffer:
> [    5.843096]    (ftrace buffer empty)
> [    5.865600] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> GOOD:
> 
> [    4.774379] erofs: (device mmcblk3p3): mounted with root inode @ nid 36.
> [    4.781362] VFS: Mounted root (erofs filesystem) readonly on device 179:3.
> [    4.788535] devtmpfs: mounted
> [    4.801822] Freeing unused kernel image (initmem) memory: 1024K
> [    4.808252] Run /sbin/init as init process
> [    4.812524]   with arguments:
> [    4.815617]     /sbin/init
> [    4.818413]   with environment:
> [    4.821740]     HOME=/
> [    4.824196]     TERM=linux
> [    4.830332] vfs_open: /usr/lib/systemd/systemd
> [    4.837634] erofs: (device mmcblk3p3): lz4        : src c1002000 dst: c1000000 in: 4096b (eec708e7, bf5f1fa0, 2) out: 8859b (3bfdda11)
> [    4.861987] erofs: bf5f1fe0 i_ino 868416, index 0 dst 810ff000 (7795d697)
> [    4.869026] erofs: bf5f1fc0 i_ino 868416, index 1 dst 810fe000 (e09f25c3)
> [    4.876096] erofs: (device mmcblk3p3): lz4        : src c1005000 dst: c100429b in: 4096b (76037b0d, bf5f1f80, 3) out: 5168b (79840434)
> [    4.888448] erofs: bf5f1fa0 i_ino 868416, index 2 dst 810fd000 (88265a45)
> [    4.895615] erofs: (device mmcblk3p3): lz4        : src c1007000 dst: c10066cb in: 4096b (4cac566d, bf5f1f60, 4) out: 6376b (dfcc8264)
> [    4.907966] erofs: bf5f1f80 i_ino 868416, index 3 dst 810fc000 (2b4319d2)
> [    4.915023] erofs: (device mmcblk3p3): lz4        : src c100a000 dst: c1008fb3 in: 4096b (74af795c, bf5f1f20, 6) out: 4651b (46c58dd7)
> [    4.927474] erofs: bf5f1f60 i_ino 868416, index 4 dst 810fb000 (7ce0249e)
> [    4.934451] erofs: bf5f1f40 i_ino 868416, index 5 dst 810fa000 (d832cf73)
> [    4.941636] erofs: (device mmcblk3p3): lz4        : src c100d000 dst: c100c1de in: 4096b (d65a3a49, bf5f1f00, 7) out: 5360b (4364e0fc)
> [    4.954065] erofs: bf5f1f20 i_ino 868416, index 6 dst 810f9000 (aa9da9e7)
> [    4.961201] erofs: (device mmcblk3p3): lz4        : src c100f000 dst: c100e6ce in: 4096b (db73bb75, bf5f1ee0, 8) out: 4606b (c0a54f50)
> [    4.973653] erofs: bf5f1f00 i_ino 868416, index 7 dst 810f8000 (372b935)
> [    4.980751] erofs: (device mmcblk3p3): lz4        : src c1011000 dst: c10108cc in: 4096b (be653c3d, bf5f1ec0, 9) out: 4536b (10b3a4d0)
> [    4.993167] erofs: bf5f1ee0 i_ino 868416, index 8 dst 810f7000 (3ebcefe7)
> [    5.000337] erofs: (device mmcblk3p3): lz4        : src c1013000 dst: c1012a84 in: 4096b (8cd3cff3, bf5f1ea0, 10) out: 4285b (541c02fb)
> [    5.012805] erofs: bf5f1ec0 i_ino 868416, index 9 dst 810f6000 (12adb98e)
> [    5.019937] erofs: (device mmcblk3p3): lz4        : src c1015000 dst: c1014b41 in: 4096b (b885e4f7, bf5f1e80, 11) out: 4789b (af1820d3)
> [    5.032473] erofs: bf5f1ea0 i_ino 868416, index 10 dst 810f5000 (e8b33507)
> [    5.039713] erofs: (device mmcblk3p3): lz4        : src c1018000 dst: c1016df6 in: 4096b (3b4e9357, bf5f1e40, 13) out: 6216b (6a149c5)
> [    5.052086] erofs: bf5f1e80 i_ino 868416, index 11 dst 810f4000 (72cdfbb)
> [    5.059166] erofs: bf5f1e60 i_ino 868416, index 12 dst 810f3000 (a4856fd6)
> [    5.066460] erofs: (device mmcblk3p3): lz4        : src c101c000 dst: c101a63e in: 4096b (a3bdbd0e, bf5f1e00, 15) out: 8015b (63d1fbc1)
> [    5.078990] erofs: bf5f1e40 i_ino 868416, index 13 dst 810f2000 (d027d81e)
> [    5.086070] erofs: bf5f1e20 i_ino 868416, index 14 dst 810f1000 (307b732a)
> [    5.093381] erofs: (device mmcblk3p3): lz4        : src c101f000 dst: c101e58d in: 4096b (480285a7, bf5f1de0, 16) out: 6603b (822f8de0)
> [    5.105920] erofs: bf5f1e00 i_ino 868416, index 15 dst 810f0000 (39882425)
> [    5.113151] erofs: (device mmcblk3p3): lz4        : src c0b49000 dst: c1020f58 in: 1839b (4f637f42, bf5f1dc0, 17) out: 5780b (55fe911f)
> [    5.125681] erofs: bf5f1de0 i_ino 868416, index 16 dst 810ef000 (7f303847)
> [    5.132765] erofs: bf5f1dc0 i_ino 868416, index 17 dst 810ee000 (7e903556)
> [    5.139925] erofs: bf5f1da0 i_ino 868416, index 18 dst 810ed000 (e3449d72)
> [    5.147999] vfs_open: hash of /usr/lib/systemd/systemd: 0x0610c635
> [    5.157814] vfs_open: /usr/lib/ld-linux-armhf.so.3
> [    5.166197] erofs: (device mmcblk3p3): lz4        : src c1025000 dst: c1024000 in: 4096b (e4b39a2, bf5f1d40, 1) out: 4907b (aa05f0a3)
> [    5.178510] erofs: bf5f1d60 i_ino 190291, index 0 dst 810eb000 (20419a5e)
> [    5.185631] erofs: (device mmcblk3p3): lz4        : src c1027000 dst: c102632b in: 4096b (717fc925, bf5f1d20, 2) out: 4246b (c0f62dca)
> [    5.197994] erofs: bf5f1d40 i_ino 190291, index 1 dst 810ea000 (64eb9a49)
> [    5.205147] erofs: (device mmcblk3p3): lz4        : src c1029000 dst: c10283c1 in: 4096b (8030d189, bf5f1d00, 3) out: 4292b (1df48c5f)
> [    5.217526] erofs: bf5f1d20 i_ino 190291, index 2 dst 810e9000 (7fc63af4)
> [    5.224711] erofs: (device mmcblk3p3): lz4        : src c102b000 dst: c102a485 in: 4096b (4aac6f77, bf5f1ce0, 4) out: 4289b (7dbbff69)
> [    5.237095] erofs: bf5f1d00 i_ino 190291, index 3 dst 810e8000 (285ac58c)
> [    5.244249] erofs: (device mmcblk3p3): lz4        : src c102d000 dst: c102c546 in: 4096b (e286b2b, bf5f1cc0, 5) out: 4207b (ec8e3f58)
> [    5.256495] erofs: bf5f1ce0 i_ino 190291, index 4 dst 810e7000 (63f2218c)
> [    5.263664] erofs: (device mmcblk3p3): lz4        : src c102f000 dst: c102e5b5 in: 4096b (e698fd35, bf5f1ca0, 6) out: 4291b (fcf580f8)
> [    5.276007] erofs: bf5f1cc0 i_ino 190291, index 5 dst 810e6000 (d2cc83a9)
> [    5.283142] erofs: (device mmcblk3p3): lz4        : src c1031000 dst: c1030678 in: 4096b (4859aa8f, bf5f1c80, 7) out: 4297b (ab8a8574)
> [    5.295590] erofs: bf5f1ca0 i_ino 190291, index 6 dst 810e5000 (fe13cf51)
> [    5.302665] erofs: (device mmcblk3p3): lz4        : src c1033000 dst: c1032741 in: 4096b (997436a4, bf5f1c60, 8) out: 4218b (be0817b8)
> [    5.315063] erofs: bf5f1c80 i_ino 190291, index 7 dst 810e4000 (a4994a5f)
> [    5.322224] erofs: (device mmcblk3p3): lz4        : src c1035000 dst: c10347bb in: 4096b (112a3fda, bf5f1c40, 9) out: 4271b (293ce253)
> [    5.334641] erofs: bf5f1c60 i_ino 190291, index 8 dst 810e3000 (9e8ba792)
> [    5.350295] erofs: (device mmcblk3p3): lz4        : src c1037000 dst: c103686a in: 4096b (fa3410b9, bf5f1c20, 10) out: 4673b (7f7a9871)
> [    5.362739] erofs: bf5f1c40 i_ino 190291, index 9 dst 810e2000 (902d97fe)
> [    5.369870] erofs: (device mmcblk3p3): lz4        : src c1039000 dst: c1038aab in: 4096b (634b03ca, bf5f1c00, 11) out: 4477b (cf289eb)
> [    5.382235] erofs: bf5f1c20 i_ino 190291, index 10 dst 810e1000 (60b7ab45)
> [    5.389407] erofs: (device mmcblk3p3): lz4        : src c103b000 dst: c103ac28 in: 4096b (326e1ba0, bf5f1be0, 12) out: 4254b (998b1f98)
> [    5.401844] erofs: bf5f1c00 i_ino 190291, index 11 dst 810e0000 (55814486)
> [    5.408944] erofs: (device mmcblk3p3): lz4        : src c103d000 dst: c103ccc6 in: 4096b (3c5b4505, bf5f1bc0, 13) out: 4175b (3bf4f1a9)
> [    5.421376] erofs: bf5f1be0 i_ino 190291, index 12 dst 810df000 (717aa17d)
> [    5.428544] erofs: (device mmcblk3p3): lz4        : src c103f000 dst: c103ed15 in: 4096b (8e87c14d, bf5f1ba0, 14) out: 4288b (6a251e64)
> [    5.441000] erofs: bf5f1bc0 i_ino 190291, index 13 dst 810de000 (36a0d885)
> [    5.448220] erofs: (device mmcblk3p3): lz4        : src c1041000 dst: c1040dd5 in: 4096b (31a2e179, bf5f1b80, 15) out: 4257b (3e19e451)
> [    5.460669] erofs: bf5f1ba0 i_ino 190291, index 14 dst 810dd000 (8890a118)
> [    5.467837] erofs: (device mmcblk3p3): lz4        : src c0b49000 dst: c1042e76 in: 4096b (65fa2fbe, bf5f1b60, 16) out: 4460b (ebe0126c)
> [    5.480272] erofs: bf5f1b80 i_ino 190291, index 15 dst 810dc000 (d48cbaf9)
> [    5.487497] erofs: (device mmcblk3p3): lz4        : src c1046000 dst: c1044fe2 in: 4096b (37a8bad1, bf5f1b20, 18) out: 4349b (c125197)
> [    5.499847] erofs: bf5f1b60 i_ino 190291, index 16 dst 810db000 (940857ad)
> [    5.506993] erofs: bf5f1b40 i_ino 190291, index 17 dst 810da000 (bd0e7a43)
> [    5.514145] erofs: (device mmcblk3p3): lz4        : src c1049000 dst: c10480df in: 4096b (8d172a42, bf5f1b00, 19) out: 4353b (1503ff28)
> [    5.526601] erofs: bf5f1b20 i_ino 190291, index 18 dst 810d9000 (dec8eb5c)
> [    5.533854] erofs: (device mmcblk3p3): lz4        : src c104b000 dst: c104a1e0 in: 4096b (1ef07e2b, bf5f1ae0, 20) out: 4869b (c3bf758b)
> [    5.546298] erofs: bf5f1b00 i_ino 190291, index 19 dst 810d8000 (6e7792a7)
> [    5.553561] erofs: (device mmcblk3p3): lz4        : src c104d000 dst: c104c4e5 in: 4096b (f4462dc1, bf5f1ac0, 21) out: 5484b (9b35c90f)
> [    5.566001] erofs: bf5f1ae0 i_ino 190291, index 20 dst 810d7000 (97b42709)
> [    5.573222] erofs: (device mmcblk3p3): lz4        : src c1050000 dst: c104ea51 in: 4096b (2ac6b4d5, bf5f1a80, 23) out: 5985b (94cc0d29)
> [    5.585714] erofs: bf5f1ac0 i_ino 190291, index 21 dst 810d6000 (29751a32)
> [    5.592805] erofs: bf5f1aa0 i_ino 190291, index 22 dst 810d5000 (eeea8a30)
> [    5.600096] erofs: (device mmcblk3p3): lz4        : src c1053000 dst: c10521b2 in: 4096b (90757c3c, bf5f1a60, 24) out: 6356b (58df129b)
> [    5.612540] erofs: bf5f1a80 i_ino 190291, index 23 dst 810d4000 (a86b83ad)
> [    5.619754] erofs: (device mmcblk3p3): lz4        : src c1056000 dst: c1054a86 in: 4096b (971b791e, bf5f1a20, 26) out: 6045b (3a6bbefa)
> [    5.632269] erofs: bf5f1a60 i_ino 190291, index 24 dst 810d3000 (2535a069)
> [    5.639307] erofs: bf5f1a40 i_ino 190291, index 25 dst 810d2000 (98287e49)
> [    5.646690] erofs: (device mmcblk3p3): lz4        : src c105a000 dst: c1058223 in: 4096b (9804bc65, bf5f19e0, 28) out: 10510b (2a60a723)
> [    5.659249] erofs: bf5f1a20 i_ino 190291, index 26 dst 810d1000 (64b12fc2)
> [    5.666330] erofs: bf5f1a00 i_ino 190291, index 27 dst 810d0000 (de4b4264)
> [    5.673557] erofs: (device mmcblk3p3): lz4        : src 829bfa35 dst: c105cb31 in: 1483b (5c99618c, bf6237e0, 0) out: 4759b (b53e5caa)
> [    5.685912] erofs: bf5f19e0 i_ino 190291, index 28 dst 810cf000 (7881835d)
> [    5.693076] erofs: bf5f19c0 i_ino 190291, index 29 dst 810ce000 (80d1e247)
> [    5.701807] vfs_open: hash of /usr/lib/ld-linux-armhf.so.3: 0xf1fe4854

After I picked "erofs: ... i_ino ...., index ...." lines out, sort them,
and use`sed -e 's/.*(\([0-9a-f]*\))$/\1/'` to parse the sorted items of
BAD and GOOD cases,

I found each decompressed page cache page (which will be visible to
the userspace) is the same, so I'm very confused why it could happen.

  - Could we get the exact file offset of `init` which init process is
    crashed?  It will help us to chase down the the primary scene.

  - Also I wonder if it exists some memory overflow issues, could you
    enable KASAN or something to find out more?

On my side, I will try to use your rootfs to find more evidence, but
from the debugging outputs, I have more clues since the decompressed
data looks correct for the BAD cases too...

Thanks,
Gao Xiang

> 
> 
> Cheers,
> Stefan
> 

