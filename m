Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 60512A182CB
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 18:22:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcvCK6Hfpz30Wq
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jan 2025 04:22:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:edc0:2:b01:1d::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737480124;
	cv=none; b=Q76Hi518m9wWVWNSxlPLrUXDjg3wz65BB1ubbWKMNkVdZFvrHCwG7q5yk8b2cOcXzpQL5VvXUDg3mffndLBMzEhBEjdBvf1n85viKczTQVDlzOxRVKKMEoeYOEV+pCHASlQGtBYOEFXNS34I6Wk2Z7jzgfkwJFT811j2eiDxWZ+UyNiX00INbNnQVrdyj+Y+WJ8ZqYxAXDjN+o75FcyFYq/DwglBA0gTLEAtjAAEfOQ8syFld6EW+ICF1MLqmNuhL2z7++dIDECos10CNZa9QZUbC9ccOur/1TqJqerN0msWS7hUIg/l4OgXyOUUYttSwO3srvDqwgQU0XHk5Gg68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737480124; c=relaxed/relaxed;
	bh=TtLUqXd2tf2GyEXzwEg9d1/qc3TQpe+d4YlOvOBwVXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jC0W6A/xyPG8i8S/ayHF0uthllR3vcuyodZNk6GWQ++d8vuGci3C/NEu4nWP2crVYHK/h5d9y3GcmKuWwrC9QgHq86JltvBF727JijXgbYnfNwgeHywMBVFQR6/xH0KuDq5ex/23xRUfdW1RHfwWrf1wdgk3/2NKclDkVH7uCjx+ylV4DBtPtczUI04q5W1J9JexogefaZ0h6A/IYNJxrAas2jAwq7tGhA+OpE9/1/+aB0T/GSF4fKdk8Leks71Uh14ZlXZkv14mBwRFtbduVHfP8nPcXSPwjHQXAati3kyOXl4Ahz0rsxoYOWfn2WqOahbPxdFb6jQtxq34ssDITQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.kerkmann@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.kerkmann@pengutronix.de; receiver=lists.ozlabs.org)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YcvCG27lLz2xy7
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Jan 2025 04:22:01 +1100 (AEDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1taHws-0002Zg-Q6; Tue, 21 Jan 2025 18:21:58 +0100
Message-ID: <8769e181-ffb5-4c54-9147-f933fbdf9572@pengutronix.de>
Date: Tue, 21 Jan 2025 18:21:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] data corruption of init process
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de>
 <14b78097-ee6a-4e91-9688-172ce807299b@linux.alibaba.com>
 <1ee54399-88ef-440e-9262-cba0bcc28c90@pengutronix.de>
 <b73823e2-a976-4831-90c7-405316440236@linux.alibaba.com>
 <109605af-8df5-49dc-be5e-81ec907bfcbf@linux.alibaba.com>
 <8d18ce00-404c-42a7-9fed-5673a71eac3e@pengutronix.de>
 <1e6554d0-5b46-47c0-a9e1-8c26dafa29b3@linux.alibaba.com>
 <a3aa2b25-be6c-4c4f-aaad-b62417a14da5@linux.alibaba.com>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <a3aa2b25-be6c-4c4f-aaad-b62417a14da5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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

Hi Gao,

I have applied your patch (with minor corrections) and here is the output. I haven't had the time today to look deeper into it unfortunately.

[    4.765049] erofs: (device mmcblk3p3): mounted with root inode @ nid 36.
[    4.772082] VFS: Mounted root (erofs filesystem) readonly on device 179:3.
[    4.779155] devtmpfs: mounted
[    4.792432] Freeing unused kernel image (initmem) memory: 1024K
[    4.798909] Run /sbin/init as init process
[    4.803219]   with arguments:
[    4.806345]     /sbin/init
[    4.809168]   with environment:
[    4.812526]     HOME=/
[    4.814998]     TERM=linux
[    4.821205] vfs_open: /usr/lib/systemd/systemd
[    4.827746] erofs: (device mmcblk3p3): lz4        : src c1002000 dst: c1000000 in: 4096b (eec708e7, bf5f1f80, 2) out: 8859b (3bfdda11)
[    4.840164] erofs: bf5f1fc0 i_ino 868416, index 0 dst 810fe000 (7795d697) err 0
[    4.847766] erofs: bf5f1fa0 i_ino 868416, index 1 dst 810fd000 (e09f25c3) err 0
[    4.862091] erofs: (device mmcblk3p3): lz4        : src c1005000 dst: c100429b in: 4096b (76037b0d, bf5f1f60, 3) out: 5168b (79840434)
[    4.874456] erofs: bf5f1f80 i_ino 868416, index 2 dst 810fc000 (88265a45) err 0
[    4.882098] erofs: (device mmcblk3p3): lz4 partial: src 82cbd000 dst: 810fb6cb in: 4096b (45bf72c3, bf6297a0, 6462) out: 2357b (6e052dd5)
[    4.894729] erofs: bf5f1f60 i_ino 868416, index 3 dst 810fb000 (2b4319d2) err 0
[    4.903346] vfs_open: /usr/lib/ld-linux-armhf.so.3
[    4.909853] erofs: (device mmcblk3p3): lz4        : src c1007000 dst: c1006000 in: 4096b (e4b39a2, bf5f1f20, 1) out: 4907b (aa05f0a3)
[    4.922134] erofs: bf5f1f40 i_ino 190291, index 0 dst 810fa000 (20419a5e) err 0
[    4.929813] erofs: (device mmcblk3p3): lz4        : src c1009000 dst: c100832b in: 4096b (717fc925, bf5f1f00, 2) out: 4246b (c0f62dca)
[    4.942938] erofs: (device mmcblk3p3): lz4        : src 82cbd000 dst: c100a6cb in: 4096b (45bf72c3, bf6297a0, 6462) out: 6376b (dfcc8264)
[    4.955668] erofs: bf5f1f20 i_ino 190291, index 1 dst 810f9000 (64eb9a49) err 0
[    4.963321] erofs: (device mmcblk3p3): lz4        : src c100d000 dst: c100c3c1 in: 4096b (8030d189, bf5f1ee0, 3) out: 4292b (1df48c5f)
[    4.975678] erofs: bf5f1f00 i_ino 190291, index 2 dst 810f8000 (7fc63af4) err 0
[    4.983363] erofs: (device mmcblk3p3): lz4 partial: src 830a8000 dst: 810f7485 in: 4096b (17ce8f99, bf631500, 1493) out: 2939b (a1ab12cf)
[    4.995957] erofs: bf5f1ee0 i_ino 190291, index 3 dst 810f7000 (285ac58c) err 0
[    5.007086] erofs: (device mmcblk3p3): lz4        : src c1010000 dst: c100efb3 in: 4096b (74af795c, bf5f1e60, 6) out: 4651b (46c58dd7)
[    5.019455] erofs: bf5f1ea0 i_ino 868416, index 4 dst 810f5000 (7ce0249e) err 0
[    5.027040] erofs: bf5f1e80 i_ino 868416, index 5 dst 810f4000 (d832cf73) err 0
[    5.034641] erofs: (device mmcblk3p3): lz4        : src c1013000 dst: c10121de in: 4096b (d65a3a49, bf5f1e40, 7) out: 5360b (4364e0fc)
[    5.046970] erofs: bf5f1e60 i_ino 868416, index 6 dst 810f3000 (aa9da9e7) err 0
[    5.054649] erofs: (device mmcblk3p3): lz4        : src c1015000 dst: c10146ce in: 4096b (db73bb75, bf5f1e20, 8) out: 4606b (c0a54f50)
[    5.067063] erofs: bf5f1e40 i_ino 868416, index 7 dst 810f2000 (372b935) err 0
[    5.074721] erofs: (device mmcblk3p3): lz4        : src c1017000 dst: c10168cc in: 4096b (be653c3d, bf5f1e00, 9) out: 4536b (10b3a4d0)
[    5.087070] erofs: bf5f1e20 i_ino 868416, index 8 dst 810f1000 (3ebcefe7) err 0
[    5.094683] erofs: (device mmcblk3p3): lz4        : src c1019000 dst: c1018a84 in: 4096b (8cd3cff3, bf5f1de0, 10) out: 4285b (541c02fb)
[    5.107120] erofs: bf5f1e00 i_ino 868416, index 9 dst 810f0000 (12adb98e) err 0
[    5.114832] erofs: (device mmcblk3p3): lz4        : src c101b000 dst: c101ab41 in: 4096b (b885e4f7, bf5f1dc0, 11) out: 4789b (af1820d3)
[    5.127409] erofs: bf5f1de0 i_ino 868416, index 10 dst 810ef000 (e8b33507) err 0
[    5.143657] erofs: (device mmcblk3p3): lz4        : src c101e000 dst: c101cdf6 in: 4096b (3b4e9357, bf5f1d80, 13) out: 6216b (6a149c5)
[    5.156017] erofs: bf5f1dc0 i_ino 868416, index 11 dst 810ee000 (72cdfbb) err 0
[    5.163505] erofs: bf5f1da0 i_ino 868416, index 12 dst 810ed000 (a4856fd6) err 0
[    5.171330] erofs: (device mmcblk3p3): lz4        : src c1022000 dst: c102063e in: 4096b (a3bdbd0e, bf5f1d40, 15) out: 8015b (63d1fbc1)
[    5.183762] erofs: bf5f1d80 i_ino 868416, index 13 dst 810ec000 (d027d81e) err 0
[    5.191414] erofs: bf5f1d60 i_ino 868416, index 14 dst 810eb000 (307b732a) err 0
[    5.199108] erofs: (device mmcblk3p3): lz4        : src c1025000 dst: c102458d in: 4096b (480285a7, bf5f1d20, 16) out: 6603b (822f8de0)
[    5.211544] erofs: bf5f1d40 i_ino 868416, index 15 dst 810ea000 (39882425) err 0
[    5.219253] erofs: (device mmcblk3p3): lz4        : src c0b49000 dst: c1026f58 in: 1839b (4f637f42, bf5f1d00, 17) out: 5780b (55fe911f)
[    5.231687] erofs: bf5f1d20 i_ino 868416, index 16 dst 810e9000 (7f303847) err 0
[    5.239317] erofs: bf5f1d00 i_ino 868416, index 17 dst 810e8000 (7e903556) err 0
[    5.246960] erofs: bf5f1ce0 i_ino 868416, index 18 dst 810e7000 (e3449d72) err 0
[    5.262766] erofs: (device mmcblk3p3): lz4        : src 830ab000 dst: c102acc6 in: 4096b (cd2f4c7c, bf631560, 1502) out: 4175b (3bf4f1a9)
[    5.275485] erofs: (device mmcblk3p3): lz4        : src c102d000 dst: c102cd15 in: 4096b (8e87c14d, bf5f1c80, 14) out: 4288b (6a251e64)
[    5.287917] erofs: bf5f1ca0 i_ino 190291, index 13 dst 810e5000 (36a0d885) err 0
[    5.295657] erofs: (device mmcblk3p3): lz4        : src c102f000 dst: c102edd5 in: 4096b (31a2e179, bf5f1c60, 15) out: 4257b (3e19e451)
[    5.308098] erofs: bf5f1c80 i_ino 190291, index 14 dst 810e4000 (8890a118) err 0
[    5.315759] erofs: (device mmcblk3p3): lz4        : src c0b49000 dst: c1030e76 in: 4096b (65fa2fbe, bf5f1c40, 16) out: 4460b (ebe0126c)
[    5.328237] erofs: bf5f1c60 i_ino 190291, index 15 dst 810e3000 (d48cbaf9) err 0
[    5.335963] erofs: (device mmcblk3p3): lz4        : src c1034000 dst: c1032fe2 in: 4096b (37a8bad1, bf5f1c00, 18) out: 4349b (c125197)
[    5.348311] erofs: bf5f1c40 i_ino 190291, index 16 dst 810e2000 (940857ad) err 0
[    5.355943] erofs: bf5f1c20 i_ino 190291, index 17 dst 810e1000 (bd0e7a43) err 0
[    5.363673] erofs: (device mmcblk3p3): lz4        : src c1037000 dst: c10360df in: 4096b (8d172a42, bf5f1be0, 19) out: 4353b (1503ff28)
[    5.376111] erofs: bf5f1c00 i_ino 190291, index 18 dst 810e0000 (dec8eb5c) err 0
[    5.383781] erofs: (device mmcblk3p3): lz4        : src c1039000 dst: c10381e0 in: 4096b (1ef07e2b, bf5f1bc0, 20) out: 4869b (c3bf758b)
[    5.396214] erofs: bf5f1be0 i_ino 190291, index 19 dst 810df000 (6e7792a7) err 0
[    5.403964] erofs: (device mmcblk3p3): lz4        : src c103b000 dst: c103a4e5 in: 4096b (f4462dc1, bf5f1ba0, 21) out: 5484b (9b35c90f)
[    5.416397] erofs: bf5f1bc0 i_ino 190291, index 20 dst 810de000 (97b42709) err 0
[    5.424162] erofs: (device mmcblk3p3): lz4        : src c103e000 dst: c103ca51 in: 4096b (2ac6b4d5, bf5f1b60, 23) out: 5985b (94cc0d29)
[    5.436597] erofs: bf5f1ba0 i_ino 190291, index 21 dst 810dd000 (29751a32) err 0
[    5.444168] erofs: bf5f1b80 i_ino 190291, index 22 dst 810dc000 (eeea8a30) err 0
[    5.451965] erofs: (device mmcblk3p3): lz4        : src c1041000 dst: c10401b2 in: 4096b (90757c3c, bf5f1b40, 24) out: 6356b (58df129b)
[    5.464395] erofs: bf5f1b60 i_ino 190291, index 23 dst 810db000 (a86b83ad) err 0
[    5.472176] erofs: (device mmcblk3p3): lz4        : src c1044000 dst: c1042a86 in: 4096b (971b791e, bf5f1b00, 26) out: 6045b (3a6bbefa)
[    5.484610] erofs: bf5f1b40 i_ino 190291, index 24 dst 810da000 (2535a069) err 0
[    5.492246] erofs: bf5f1b20 i_ino 190291, index 25 dst 810d9000 (98287e49) err 0
[    5.500043] erofs: (device mmcblk3p3): lz4        : src c1048000 dst: c1046223 in: 4096b (9804bc65, bf5f1ac0, 28) out: 10510b (2a60a723)
[    5.512834] erofs: bf5f1b00 i_ino 190291, index 26 dst 810d8000 (64b12fc2) err 0
[    5.520495] erofs: bf5f1ae0 i_ino 190291, index 27 dst 810d7000 (de4b4264) err 0
[    5.528179] erofs: (device mmcblk3p3): lz4        : src 830aca35 dst: c104ab31 in: 1483b (5c99618c, bf631580, 0) out: 4759b (b53e5caa)
[    5.540810] erofs: bf5f1ac0 i_ino 190291, index 28 dst 810d6000 (7881835d) err 0
[    5.548449] erofs: bf5f1aa0 i_ino 190291, index 29 dst 810d5000 (80d1e247) err 0
[    5.560729] erofs: (device mmcblk3p3): lz4        : src 830a8000 dst: c104c485 in: 4096b (17ce8f99, bf631500, 1493) out: 4289b (7dbbff69)
[    5.573541] erofs: (device mmcblk3p3): lz4 partial: src 830ab000 dst: 810cacc6 in: 4096b (cd2f4c7c, bf631560, 1502) out: 826b (21762da4)
[    5.591796] erofs: (device mmcblk3p3): lz4        : src c104f000 dst: c104e546 in: 4096b (e286b2b, bf5f1a20, 5) out: 4207b (ec8e3f58)
[    5.604130] erofs: bf5f1a40 i_ino 190291, index 4 dst 810d2000 (63f2218c) err 0
[    5.611835] erofs: (device mmcblk3p3): lz4        : src c1051000 dst: c10505b5 in: 4096b (e698fd35, bf5f1a00, 6) out: 4291b (fcf580f8)
[    5.624404] erofs: bf5f1a20 i_ino 190291, index 5 dst 810d1000 (d2cc83a9) err 0
[    5.632158] erofs: (device mmcblk3p3): lz4        : src c1053000 dst: c1052678 in: 4096b (4859aa8f, bf5f19e0, 7) out: 4297b (ab8a8574)
[    5.644522] erofs: bf5f1a00 i_ino 190291, index 6 dst 810d0000 (fe13cf51) err 0
[    5.652188] erofs: (device mmcblk3p3): lz4        : src c1055000 dst: c1054741 in: 4096b (997436a4, bf5f19c0, 8) out: 4218b (be0817b8)
[    5.664551] erofs: bf5f19e0 i_ino 190291, index 7 dst 810cf000 (a4994a5f) err 0
[    5.672199] erofs: (device mmcblk3p3): lz4        : src c1057000 dst: c10567bb in: 4096b (112a3fda, bf5f19a0, 9) out: 4271b (293ce253)
[    5.684561] erofs: bf5f19c0 i_ino 190291, index 8 dst 810ce000 (9e8ba792) err 0
[    5.692214] erofs: (device mmcblk3p3): lz4        : src c1059000 dst: c105886a in: 4096b (fa3410b9, bf5f1980, 10) out: 4673b (7f7a9871)
[    5.704675] erofs: bf5f19a0 i_ino 190291, index 9 dst 810cd000 (902d97fe) err 0
[    5.712242] erofs: (device mmcblk3p3): lz4        : src c105b000 dst: c105aaab in: 4096b (634b03ca, bf5f1960, 11) out: 4477b (cf289eb)
[    5.724628] erofs: bf5f1980 i_ino 190291, index 10 dst 810cc000 (60b7ab45) err 0
[    5.732329] 8<--- cut here ---
[    5.735476] init: unhandled page fault (11) at 0x6f532180, code 0x005
[    5.742271] erofs: (device mmcblk3p3): lz4        : src 830ac000 dst: c105cc28 in: 4096b (163cdf49, bf631580, 0) out: 4254b (998b1f98)
[    5.754643] erofs: bf5f1960 i_ino 190291, index 11 dst 810cb000 (55814486) err 0
[    5.762301] erofs: bf5f1940 i_ino 190291, index 12 dst 810ca000 (717aa17d) err 0
[    5.769871] [6f532180] *pgd=00000000
[    5.773686] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.12.10-00014-g1f2f4d02b240-dirty #117
[    5.782503] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    5.789264] PC is at 0x76f5cc86
[    5.792568] LR is at 0x76f632a5
[    5.795806] pc : [<76f5cc86>]    lr : [<76f632a5>]    psr: 20001430
[    5.802270] sp : 7e8ece68  ip : 76f71000  fp : 00000016
[    5.807603] r10: 76f53000  r9 : 76f715f0  r8 : 76f70ce0
[    5.813037] r7 : 7e8ece80  r6 : 76f71000  r5 : 00000003  r4 : 76f53148
[    5.819743] r3 : 00000008  r2 : 6f532180  r1 : 00000001  r0 : 76f715f0
[    5.826377] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA Thumb  Segment user
[    5.834031] Control: 50c5387d  Table: 136b004a  DAC: 00000055
[    5.839892] Call trace: 
[    5.840018] exit: bf5f1f40 i_ino 190291, index 0 (20419a5e)
[    5.842725] exit: bf5f1f20 i_ino 190291, index 1 (64eb9a49)
[    5.848514] exit: bf5f1f00 i_ino 190291, index 2 (7fc63af4)
[    5.854319] exit: bf5f1ee0 i_ino 190291, index 3 (285ac58c)
[    5.860177] exit: bf5f1a40 i_ino 190291, index 4 (63f2218c)
[    5.865901] exit: bf5f1a20 i_ino 190291, index 5 (d2cc83a9)
[    5.871722] exit: bf5f1a00 i_ino 190291, index 6 (fe13cf51)
[    5.877463] exit: bf5f19e0 i_ino 190291, index 7 (a4994a5f)
[    5.883300] exit: bf5f19c0 i_ino 190291, index 8 (9e8ba792)
[    5.889025] exit: bf5f19a0 i_ino 190291, index 9 (902d97fe)
[    5.894850] exit: bf5f1980 i_ino 190291, index 10 (60b7ab45)
[    5.900658] exit: bf5f1960 i_ino 190291, index 11 (55814486)
[    5.906652] exit: bf5f1940 i_ino 190291, index 12 (717aa17d)
[    5.912540] exit: bf5f1ca0 i_ino 190291, index 13 (36a0d885)
[    5.918426] exit: bf5f1c80 i_ino 190291, index 14 (8890a118)
[    5.924260] exit: bf5f1c60 i_ino 190291, index 15 (d48cbaf9)
[    5.930299] exit: bf5f1c40 i_ino 190291, index 16 (940857ad)
[    5.936157] exit: bf5f1c20 i_ino 190291, index 17 (bd0e7a43)
[    5.942062] exit: bf5f1c00 i_ino 190291, index 18 (dec8eb5c)
[    5.947890] exit: bf5f1be0 i_ino 190291, index 19 (6e7792a7)
[    5.953840] exit: bf5f1bc0 i_ino 190291, index 20 (97b42709)
[    5.959670] exit: bf5f1ba0 i_ino 190291, index 21 (29751a32)
[    5.965569] exit: bf5f1b80 i_ino 190291, index 22 (eeea8a30)
[    5.971399] exit: bf5f1b60 i_ino 190291, index 23 (a86b83ad)
[    5.977273] exit: bf5f1b40 i_ino 190291, index 24 (2535a069)
[    5.983145] exit: bf5f1b20 i_ino 190291, index 25 (98287e49)
[    5.989021] exit: bf5f1b00 i_ino 190291, index 26 (64b12fc2)
[    6.007435] exit: bf5f1ae0 i_ino 190291, index 27 (de4b4264)
[    6.007507] exit: bf5f1ac0 i_ino 190291, index 28 (7881835d)
[    6.013353] exit: bf5f1aa0 i_ino 190291, index 29 (80d1e247)
[    6.019169] exit: bf5f1fc0 i_ino 868416, index 0 (7795d697)
[    6.025058] exit: bf5f1fa0 i_ino 868416, index 1 (e09f25c3)
[    6.030896] exit: bf5f1f80 i_ino 868416, index 2 (88265a45)
[    6.036740] exit: bf5f1f60 i_ino 868416, index 3 (2b4319d2)
[    6.042504] exit: bf5f1ea0 i_ino 868416, index 4 (7ce0249e)
[    6.048309] exit: bf5f1e80 i_ino 868416, index 5 (d832cf73)
[    6.054132] exit: bf5f1e60 i_ino 868416, index 6 (aa9da9e7)
[    6.060033] exit: bf5f1e40 i_ino 868416, index 7 (372b935)
[    6.065827] exit: bf5f1e20 i_ino 868416, index 8 (3ebcefe7)
[    6.071554] exit: bf5f1e00 i_ino 868416, index 9 (12adb98e)
[    6.077300] exit: bf5f1de0 i_ino 868416, index 10 (e8b33507)
[    6.083161] exit: bf5f1dc0 i_ino 868416, index 11 (72cdfbb)
[    6.088985] exit: bf5f1da0 i_ino 868416, index 12 (a4856fd6)
[    6.094799] exit: bf5f1d80 i_ino 868416, index 13 (d027d81e)
[    6.100644] exit: bf5f1d60 i_ino 868416, index 14 (307b732a)
[    6.106519] exit: bf5f1d40 i_ino 868416, index 15 (39882425)
[    6.112381] exit: bf5f1d20 i_ino 868416, index 16 (7f303847)
[    6.118273] exit: bf5f1d00 i_ino 868416, index 17 (7e903556)
[    6.124159] exit: bf5f1ce0 i_ino 868416, index 18 (e3449d72)
[    6.130080] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    6.143641] Dumping ftrace buffer:
[    6.147131]    (ftrace buffer empty)
[    6.170722] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Cheers,
Stefan

On 21.01.25 04:33, Gao Xiang wrote:
> 
> 
> On 2025/1/21 11:27, Gao Xiang wrote:
>>
>>
>> On 2025/1/21 01:36, Stefan Kerkmann wrote:
>>> Hi Gao,
>>>
>>> I have enabled KASAN and applied your requested changes, but nothing
>>> suspicious happened.
>>
>> Sigh...
>>
>>>
>>>> - Could we get the exact file offset of `init` which init process is
>>>>    crashed?  It will help us to chase down the the primary scene.
>>>
>>> I'll try to track that down. If you have any hints how to-do that let me
>>> know :-).
>>
>> Many thanks for the test...
>> I just hacked some code but un-tested as below:
>>
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 1dcddfe537ee..868fea16732f 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -873,6 +873,8 @@ static void synchronize_group_exit(struct task_struct
>> *tsk, long code)
>>       spin_unlock_irq(&sighand->siglock);
>>   }
>>
>> +extern struct inode *erofs_iget(struct super_block *sb, u64 nid);
>> +
>>   void __noreturn do_exit(long code)
>>   {
>>       struct task_struct *tsk = current;
>> @@ -903,9 +905,59 @@ void __noreturn do_exit(long code)
>>            * If the last thread of global init has exited, panic
>>            * immediately to get a useable coredump.
>>            */
>> -        if (unlikely(is_global_init(tsk)))
>> +        if (unlikely(is_global_init(tsk))) {
>> +            struct path path;
>> +            struct inode *inode;
>> +
>> +            get_fs_pwd(tsk->fs, &path);
>> +
>> +            inode = d_inode(path.dentry);
>> +            if (inode && inode->i_sb->s_magic == EROFS_SUPER_MAGIC_V1) {
>> +                struct inode *inode;
>> +                int i = 0;
>> +
>> +                inode = erofs_iget(inode->i_sb, 190291);
>> +                if (IS_ERR(inode))
>> +                    goto skip;
>> +
>> +                for (i = 0; i < 30; ++i) {
>> +                    struct page *page = find_get_page(inode->i_mapping, i);
>> +                    void *data;
>> +
>> +                    if (!page)
>> +                        continue;
>> +                    data = kmap_local_page(page);
>> +
>> +                    hash = fnv_32_buf(data, PAGE_SIZE, FNV1_32_INIT);
>> +                    pr_err("%px i_ino %lu, index %lu dst %px (%x) err %d",
>> +                           page, page->mapping->host->i_ino, i, ptr, hash);
> 
> maybe use some different style in this print message:
> 
>         "exit: %px i_ino %lu, index %lu dst %px (%x)"
> 
> likewise.
> 
> Anyway, it's somewhat hack code, just wonder if it works, and
> the output is helpful for us to know which page is corrupt.
> 
> 
>> +                    kunmap_local(data);
>> +                }
>> +                iput(inode);
>> +
>> +                inode = erofs_iget(inode->i_sb, 868416);
>> +                if (IS_ERR(inode))
>> +                    goto skip;
>> +
>> +                for (i = 0; i < 19; ++i) {
>> +                    struct page *page = find_get_page(inode->i_mapping, i);
>> +                    void *data;
>> +
>> +                    if (!page)
>> +                        continue;
>> +                    data = kmap_local_page(page);
>> +                    hash = fnv_32_buf(data, PAGE_SIZE, FNV1_32_INIT);
>> +                    pr_err("%px i_ino %lu, index %lu dst %px (%x) err %d",
>> +                           page, page->mapping->host->i_ino, i, ptr, hash);
>> +                    kunmap_local(data);
>> +                }
>> +                iput(inode);
>> +            }
>> +skip:
>>               panic("Attempted to kill init! exitcode=0x%08x\n",
>>                   tsk->signal->group_exit_code ?: (int)code);
>> +        }
>> +
>>
>>   #ifdef CONFIG_POSIX_TIMERS
>>           hrtimer_cancel(&tsk->signal->real_timer);
>>
>> You could follow the idea to dump the page cache data when init
>> is killed, I wonder the output...
>>
>>
>> Thanks,
>> Gao Xiang
> 
> 

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |

