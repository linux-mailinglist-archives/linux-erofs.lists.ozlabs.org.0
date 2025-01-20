Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42595A1720A
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 18:36:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcHZx0rksz30Tx
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 04:36:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:edc0:2:b01:1d::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737394614;
	cv=none; b=cDOAA5RauHhrCNpee3wQ6w88S7y0M6SGHXRmFC/2tYBlJU5IPiQIu7L580WJHVXOPJkjAae2fh8vEli9Qa6iGyXFpOU2xOpuS/z2RpxNUJSOGugcwbg3nZYElxPfPsUDSxern07DzCWnWKG+bsSaDw6Npf9t6pQQ/poOc0JOn151tkGpplnw+mdILwPk8gZiXawYR/vgiYVygCcF3QhMjLZlBApdNJ5YVoMVKgHv5NKn735xo+FmduDfw50MjouSt6JW4xiGtDWFPQXwA8AoDHgRVDmhb9dGjT7cVnXX0Rp7pXFJx8cYVKaa2bQCxAPi/fUYfV9EaAw/CICArmpWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737394614; c=relaxed/relaxed;
	bh=ssdGKMkBxmUKK46Xg8KOc/u7cF6ifEbkd16vi0hwbgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K+GTph7rB6sug9BdwnLafoKqeHAyiwxaheuswp2o+HRxPMnV1UKAv9lvTXofEpU3G6In28aZvkZ3NNjIyQWhv5AgIRMFV04vz/p+jfiG3wLynW1Wyxwn3wIbC5e+mYAJE8q4ULPV8a1+LjzOr1slSDwqvsa7v8Bq7dsoi6WERymcAicNVoESGzVL2HcTezICXxkCvJrCR+GIfwTBghT6rTTQL5bRFpQGxv2U98ChFaTeblUBv2IrMXlZGbVN+iq4EH2/45lMF5ZyslFVvQSjtptGkm1sDljJr9t/wQM2T0V3NeuaGXzPB+w5wDG1Q2w9O9Pfg7DRwkSqGsXQV9KhFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.kerkmann@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.kerkmann@pengutronix.de; receiver=lists.ozlabs.org)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YcHZr0XWdz2y8W
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Jan 2025 04:36:50 +1100 (AEDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1tZvhd-0007wZ-HV; Mon, 20 Jan 2025 18:36:45 +0100
Message-ID: <8d18ce00-404c-42a7-9fed-5673a71eac3e@pengutronix.de>
Date: Mon, 20 Jan 2025 18:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] data corruption of init process
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de>
 <14b78097-ee6a-4e91-9688-172ce807299b@linux.alibaba.com>
 <1ee54399-88ef-440e-9262-cba0bcc28c90@pengutronix.de>
 <b73823e2-a976-4831-90c7-405316440236@linux.alibaba.com>
 <109605af-8df5-49dc-be5e-81ec907bfcbf@linux.alibaba.com>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <109605af-8df5-49dc-be5e-81ec907bfcbf@linux.alibaba.com>
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

I have enabled KASAN and applied your requested changes, but nothing suspicious happened.

> - Could we get the exact file offset of `init` which init process is
>   crashed?  It will help us to chase down the the primary scene. 

I'll try to track that down. If you have any hints how to-do that let me know :-).

On 20.01.25 02:55, Gao Xiang wrote:
> 
> 
> On 2025/1/20 09:45, Gao Xiang wrote:
> 
> ...
> 
>>
>> After I picked "erofs: ... i_ino ...., index ...." lines out, sort them,
>> and use`sed -e 's/.*(\([0-9a-f]*\))$/\1/'` to parse the sorted items of
>> BAD and GOOD cases,
>>
>> I found each decompressed page cache page (which will be visible to
>> the userspace) is the same, so I'm very confused why it could happen.
>>
> 
>     - First of all, could you also confirm the output if the following
>       patch is applied:
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0cd6b5c4df98..3c2cff623016 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -264,6 +264,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err)
>         if (v & ~EROFS_ONLINEFOLIO_EIO)
>                 return;
>         folio->private = 0;
> +       ptr = kmap_local_folio(folio, 0);
> +       hash = fnv_32_buf(ptr, PAGE_SIZE, FNV1_32_INIT);
> +       erofs_info(NULL, "%px i_ino %lu, index %lu dst %px (%x) err %d",
> +                  folio, folio->mapping->host->i_ino, folio->index, ptr, hash,
> +                  v & EROFS_ONLINEFOLIO_EIO);
>         folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
>  }
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index aff09f94afb2..39d857acd3d0 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1847,7 +1847,7 @@ static int z_erofs_read_folio(struct file *file, struct
> folio *folio)
> 
>         /* if some pclusters are ready, need submit them anyway */
>         err = z_erofs_runqueue(&f, 0) ?: err;
> -       if (err && err != -EINTR)
> +       if (err)
>                 erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
>                           err, folio->index, EROFS_I(inode)->nid);
> 
> I'd like to know if some error is returned (especially EINTR) to
> user space which could cause something...
> 

Here is the fresh debug output with your requested changes, and KASAN enabled. Ftrace
failed to patch `drm_modeset_acquire_fini` which seems unrelated, but produces an 
ftrace warning. The additional error debugging didn't show any errors.


BAD:

[   12.426636] erofs: (device mmcblk3p3): mounted with root inode @ nid 36.
[   12.434840] VFS: Mounted root (erofs filesystem) readonly on device 179:3.
[   12.442981] devtmpfs: mounted
[   12.506218] Freeing unused kernel image (initmem) memory: 1024K
[   12.513733] Run /sbin/init as init process
[   12.518403]   with arguments:
[   12.521684]     /sbin/init
[   12.524739]   with environment:
[   12.528408]     HOME=/
[   12.531101]     TERM=linux
[   12.548455] vfs_open: /usr/lib/systemd/systemd
[   12.562482] erofs: (device mmcblk3p3): lz4        : src c1202000 dst: c1200000 in: 4096b (eec708e7, bf629f80, 2) out: 8859b (3bfdda11)
[   12.575957] erofs: bf629fc0 i_ino 868416, index 0 dst 82cfe000 (7795d697) err 0
[   12.583776] erofs: bf629fa0 i_ino 868416, index 1 dst 82cfd000 (e09f25c3) err 0
[   12.593173] erofs: (device mmcblk3p3): lz4        : src c1205000 dst: c120429b in: 4096b (76037b0d, bf629f60, 3) out: 5168b (79840434)
[   12.606191] erofs: bf629f80 i_ino 868416, index 2 dst 82cfc000 (88265a45) err 0
[   12.614418] erofs: (device mmcblk3p3): lz4 partial: src 8576b000 dst: 82cfb6cb in: 4096b (45bf72c3, bf67ed60, 6462) out: 2357b (6e052dd5)
[   12.627615] erofs: bf629f60 i_ino 868416, index 3 dst 82cfb000 (2b4319d2) err 0
[   12.636953] vfs_open: /usr/lib/ld-linux-armhf.so.3
[   12.645023] erofs: (device mmcblk3p3): lz4        : src c1207000 dst: c1206000 in: 4096b (e4b39a2, bf629f20, 1) out: 4907b (aa05f0a3)
[   12.657938] erofs: bf629f40 i_ino 190291, index 0 dst 82cfa000 (20419a5e) err 0
[   12.665969] erofs: (device mmcblk3p3): lz4        : src c1209000 dst: c120832b in: 4096b (717fc925, bf629f00, 2) out: 4246b (c0f62dca)
[   12.679140] erofs: bf629f20 i_ino 190291, index 1 dst 82cf9000 (64eb9a49) err 0
[   12.687258] erofs: (device mmcblk3p3): lz4        : src c120b000 dst: c120a3c1 in: 4096b (8030d189, bf629ee0, 3) out: 4292b (1df48c5f)
[   12.704323] erofs: bf629f00 i_ino 190291, index 2 dst 82cf8000 (7fc63af4) err 0
[   12.712456] erofs: (device mmcblk3p3): lz4 partial: src 84dfe000 dst: 82cf7485 in: 4096b (17ce8f99, bf66bfc0, 1493) out: 2939b (a1ab12cf)
[   12.725580] erofs: bf629ee0 i_ino 190291, index 3 dst 82cf7000 (285ac58c) err 0
[   12.733728] erofs: (device mmcblk3p3): lz4        : src 8576b000 dst: c120c6cb in: 4096b (45bf72c3, bf67ed60, 6462) out: 6376b (dfcc8264)
[   12.749045] erofs: (device mmcblk3p3): lz4        : src c1210000 dst: c120efb3 in: 4096b (74af795c, bf629e60, 6) out: 4651b (46c58dd7)
[   12.762153] erofs: bf629ea0 i_ino 868416, index 4 dst 82cf5000 (7ce0249e) err 0
[   12.770114] erofs: bf629e80 i_ino 868416, index 5 dst 82cf4000 (d832cf73) err 0
[   12.778493] erofs: (device mmcblk3p3): lz4        : src c1213000 dst: c12121de in: 4096b (d65a3a49, bf629e40, 7) out: 5360b (4364e0fc)
[   12.791427] erofs: bf629e60 i_ino 868416, index 6 dst 82cf3000 (aa9da9e7) err 0
[   12.799777] erofs: (device mmcblk3p3): lz4        : src c1215000 dst: c12146ce in: 4096b (db73bb75, bf629e20, 8) out: 4606b (c0a54f50)
[   12.812720] erofs: bf629e40 i_ino 868416, index 7 dst 82cf2000 (372b935) err 0
[   12.820903] erofs: (device mmcblk3p3): lz4        : src c1217000 dst: c12168cc in: 4096b (be653c3d, bf629e00, 9) out: 4536b (10b3a4d0)
[   12.833837] erofs: bf629e20 i_ino 868416, index 8 dst 82cf1000 (3ebcefe7) err 0
[   12.841887] erofs: (device mmcblk3p3): lz4        : src c1219000 dst: c1218a84 in: 4096b (8cd3cff3, bf629de0, 10) out: 4285b (541c02fb)
[   12.854853] erofs: bf629e00 i_ino 868416, index 9 dst 82cf0000 (12adb98e) err 0
[   12.863148] erofs: (device mmcblk3p3): lz4        : src c121b000 dst: c121ab41 in: 4096b (b885e4f7, bf629dc0, 11) out: 4789b (af1820d3)
[   12.876074] erofs: bf629de0 i_ino 868416, index 10 dst 82cef000 (e8b33507) err 0
[   12.884660] erofs: (device mmcblk3p3): lz4        : src c121e000 dst: c121cdf6 in: 4096b (3b4e9357, bf629d80, 13) out: 6216b (6a149c5)
[   12.897597] erofs: bf629dc0 i_ino 868416, index 11 dst 82cee000 (72cdfbb) err 0
[   12.905625] erofs: bf629da0 i_ino 868416, index 12 dst 82ced000 (a4856fd6) err 0
[   12.914182] erofs: (device mmcblk3p3): lz4        : src c1222000 dst: c122063e in: 4096b (a3bdbd0e, bf629d40, 15) out: 8015b (63d1fbc1)
[   12.927174] erofs: bf629d80 i_ino 868416, index 13 dst 82cec000 (d027d81e) err 0
[   12.935288] erofs: bf629d60 i_ino 868416, index 14 dst 82ceb000 (307b732a) err 0
[   12.943878] erofs: (device mmcblk3p3): lz4        : src c1225000 dst: c122458d in: 4096b (480285a7, bf629d20, 16) out: 6603b (822f8de0)
[   12.956839] erofs: bf629d40 i_ino 868416, index 15 dst 82cea000 (39882425) err 0
[   12.965195] erofs: (device mmcblk3p3): lz4        : src c0995000 dst: c1226f58 in: 1839b (4f637f42, bf629d00, 17) out: 5780b (55fe911f)
[   12.978112] erofs: bf629d20 i_ino 868416, index 16 dst 82ce9000 (7f303847) err 0
[   12.986302] erofs: bf629d00 i_ino 868416, index 17 dst 82ce8000 (7e903556) err 0
[   12.994445] erofs: bf629ce0 i_ino 868416, index 18 dst 82ce7000 (e3449d72) err 0
[   13.008153] erofs: (device mmcblk3p3): lz4        : src 8a941000 dst: c122acc6 in: 4096b (cd2f4c7c, bf722820, 1502) out: 4175b (3bf4f1a9)
[   13.021553] erofs: (device mmcblk3p3): lz4        : src c122d000 dst: c122cd15 in: 4096b (8e87c14d, bf629c80, 14) out: 4288b (6a251e64)
[   13.035036] erofs: bf629ca0 i_ino 190291, index 13 dst 82ce5000 (36a0d885) err 0
[   13.043082] erofs: (device mmcblk3p3): lz4        : src c122f000 dst: c122edd5 in: 4096b (31a2e179, bf629c60, 15) out: 4257b (3e19e451)
[   13.056118] erofs: bf629c80 i_ino 190291, index 14 dst 82ce4000 (8890a118) err 0
[   13.064539] erofs: (device mmcblk3p3): lz4        : src c0995000 dst: c1230e76 in: 4096b (65fa2fbe, bf629c40, 16) out: 4460b (ebe0126c)
[   13.077523] erofs: bf629c60 i_ino 190291, index 15 dst 82ce3000 (d48cbaf9) err 0
[   13.085882] erofs: (device mmcblk3p3): lz4        : src c1234000 dst: c1232fe2 in: 4096b (37a8bad1, bf629c00, 18) out: 4349b (c125197)
[   13.098698] erofs: bf629c40 i_ino 190291, index 16 dst 82ce2000 (940857ad) err 0
[   13.106662] erofs: bf629c20 i_ino 190291, index 17 dst 82ce1000 (bd0e7a43) err 0
[   13.115095] erofs: (device mmcblk3p3): lz4        : src c1237000 dst: c12360df in: 4096b (8d172a42, bf629be0, 19) out: 4353b (1503ff28)
[   13.128027] erofs: bf629c00 i_ino 190291, index 18 dst 82ce0000 (dec8eb5c) err 0
[   13.136516] erofs: (device mmcblk3p3): lz4        : src c1239000 dst: c12381e0 in: 4096b (1ef07e2b, bf629bc0, 20) out: 4869b (c3bf758b)
[   13.149443] erofs: bf629be0 i_ino 190291, index 19 dst 82cdf000 (6e7792a7) err 0
[   13.157914] erofs: (device mmcblk3p3): lz4        : src c123b000 dst: c123a4e5 in: 4096b (f4462dc1, bf629ba0, 21) out: 5484b (9b35c90f)
[   13.170901] erofs: bf629bc0 i_ino 190291, index 20 dst 82cde000 (97b42709) err 0
[   13.179293] erofs: (device mmcblk3p3): lz4        : src c123e000 dst: c123ca51 in: 4096b (2ac6b4d5, bf629b60, 23) out: 5985b (94cc0d29)
[   13.192215] erofs: bf629ba0 i_ino 190291, index 21 dst 82cdd000 (29751a32) err 0
[   13.200369] erofs: bf629b80 i_ino 190291, index 22 dst 82cdc000 (eeea8a30) err 0
[   13.209106] erofs: (device mmcblk3p3): lz4        : src c1241000 dst: c12401b2 in: 4096b (90757c3c, bf629b40, 24) out: 6356b (58df129b)
[   13.222139] erofs: bf629b60 i_ino 190291, index 23 dst 82cdb000 (a86b83ad) err 0
[   13.230560] erofs: (device mmcblk3p3): lz4        : src c1244000 dst: c1242a86 in: 4096b (971b791e, bf629b00, 26) out: 6045b (3a6bbefa)
[   13.243775] erofs: bf629b40 i_ino 190291, index 24 dst 82cda000 (2535a069) err 0
[   13.251650] erofs: bf629b20 i_ino 190291, index 25 dst 82cd9000 (98287e49) err 0
[   13.260532] erofs: (device mmcblk3p3): lz4        : src c1248000 dst: c1246223 in: 4096b (9804bc65, bf629ac0, 28) out: 10510b (2a60a723)
[   13.273585] erofs: bf629b00 i_ino 190291, index 26 dst 82cd8000 (64b12fc2) err 0
[   13.281783] erofs: bf629ae0 i_ino 190291, index 27 dst 82cd7000 (de4b4264) err 0
[   13.289966] erofs: (device mmcblk3p3): lz4        : src 8a942a35 dst: c124ab31 in: 1483b (5c99618c, bf722840, 0) out: 4759b (b53e5caa)
[   13.302839] erofs: bf629ac0 i_ino 190291, index 28 dst 82cd6000 (7881835d) err 0
[   13.311032] erofs: bf629aa0 i_ino 190291, index 29 dst 82cd5000 (80d1e247) err 0
[   13.322206] erofs: (device mmcblk3p3): lz4        : src 84dfe000 dst: c124c485 in: 4096b (17ce8f99, bf66bfc0, 1493) out: 4289b (7dbbff69)
[   13.335623] erofs: (device mmcblk3p3): lz4 partial: src 8a941000 dst: 82ccacc6 in: 4096b (cd2f4c7c, bf722820, 1502) out: 826b (21762da4)
[   13.350514] erofs: (device mmcblk3p3): lz4        : src c124f000 dst: c124e546 in: 4096b (e286b2b, bf629a20, 5) out: 4207b (ec8e3f58)
[   13.363515] erofs: bf629a40 i_ino 190291, index 4 dst 82cd2000 (63f2218c) err 0
[   13.371728] erofs: (device mmcblk3p3): lz4        : src c1251000 dst: c12505b5 in: 4096b (e698fd35, bf629a00, 6) out: 4291b (fcf580f8)
[   13.384693] erofs: bf629a20 i_ino 190291, index 5 dst 82cd1000 (d2cc83a9) err 0
[   13.392657] erofs: (device mmcblk3p3): lz4        : src c1253000 dst: c1252678 in: 4096b (4859aa8f, bf6299e0, 7) out: 4297b (ab8a8574)
[   13.405564] erofs: bf629a00 i_ino 190291, index 6 dst 82cd0000 (fe13cf51) err 0
[   13.413748] erofs: (device mmcblk3p3): lz4        : src c1255000 dst: c1254741 in: 4096b (997436a4, bf6299c0, 8) out: 4218b (be0817b8)
[   13.426693] erofs: bf6299e0 i_ino 190291, index 7 dst 82ccf000 (a4994a5f) err 0
[   13.434899] erofs: (device mmcblk3p3): lz4        : src c1257000 dst: c12567bb in: 4096b (112a3fda, bf6299a0, 9) out: 4271b (293ce253)
[   13.447852] erofs: bf6299c0 i_ino 190291, index 8 dst 82cce000 (9e8ba792) err 0
[   13.455875] erofs: (device mmcblk3p3): lz4        : src c1259000 dst: c125886a in: 4096b (fa3410b9, bf629980, 10) out: 4673b (7f7a9871)
[   13.469132] erofs: bf6299a0 i_ino 190291, index 9 dst 82ccd000 (902d97fe) err 0
[   13.477144] erofs: (device mmcblk3p3): lz4        : src c125b000 dst: c125aaab in: 4096b (634b03ca, bf629960, 11) out: 4477b (cf289eb)
[   13.490084] erofs: bf629980 i_ino 190291, index 10 dst 82ccc000 (60b7ab45) err 0
[   13.498423] erofs: (device mmcblk3p3): lz4        : src 8a942000 dst: c125cc28 in: 4096b (163cdf49, bf722840, 0) out: 4254b (998b1f98)
[   13.511449] erofs: bf629960 i_ino 190291, index 11 dst 82ccb000 (55814486) err 0
[   13.519586] erofs: bf629940 i_ino 190291, index 12 dst 82cca000 (717aa17d) err 0
[   13.528275] 8<--- cut here ---
[   13.531897] init: unhandled page fault (11) at 0x34715a30, code 0x805
[   13.539075] [34715a30] *pgd=00000000
[   13.542989] CPU: 0 UID: 0 PID: 1 Comm: init Tainted: G        W          6.12.10-00014-g04b474955c55 #113
[   13.553255] Tainted: [W]=WARN
[   13.556877] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   13.563709] PC is at 0x66cf4268
[   13.567385] LR is at 0x66cfa50f
[   13.571055] pc : [<66cf4268>]    lr : [<66cfa50f>]    psr: 20000030
[   13.577675] sp : 6ebe3b48  ip : 66ce73a2  fp : 66ce7000
[   13.583458] r10: 66d07944  r9 : 6ebe3ba0  r8 : 66ce700c
[   13.589123] r7 : 6ebe3b58  r6 : 00000063  r5 : 20000000  r4 : 66d07a30
[   13.596384] r3 : 66d07000  r2 : 3683d180  r1 : 004ae500  r0 : cda0e000
[   13.603256] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA Thumb  Segment user
[   13.611331] Control: 50c5387d  Table: 1aa2804a  DAC: 00000055
[   13.617670] Call trace:
[   13.617969] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   13.628774] Dumping ftrace buffer:
[   13.632700] # WARNING: FUNCTION TRACING IS CORRUPTED
[   13.637961] #          MAY BE MISSING FUNCTION EVENTS
[   13.643538]    (ftrace buffer empty)
[   13.714791] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

GOOD:

[   12.454158] erofs: (device mmcblk3p3): mounted with root inode @ nid 36.
[   12.462236] VFS: Mounted root (erofs filesystem) readonly on device 179:3.
[   12.470486] devtmpfs: mounted
[   12.533635] Freeing unused kernel image (initmem) memory: 1024K
[   12.541205] Run /sbin/init as init process
[   12.545615]   with arguments:
[   12.548878]     /sbin/init
[   12.552130]   with environment:
[   12.555840]     HOME=/
[   12.558497]     TERM=linux
[   12.575847] vfs_open: /usr/lib/systemd/systemd
[   12.592662] erofs: (device mmcblk3p3): lz4        : src c1202000 dst: c1200000 in: 4096b (eec708e7, bf629fa0, 2) out: 8859b (3bfdda11)
[   12.605809] erofs: bf629fe0 i_ino 868416, index 0 dst 82cff000 (7795d697) err 0
[   12.613719] erofs: bf629fc0 i_ino 868416, index 1 dst 82cfe000 (e09f25c3) err 0
[   12.622151] erofs: (device mmcblk3p3): lz4        : src c1205000 dst: c120429b in: 4096b (76037b0d, bf629f80, 3) out: 5168b (79840434)
[   12.635102] erofs: bf629fa0 i_ino 868416, index 2 dst 82cfd000 (88265a45) err 0
[   12.643606] erofs: (device mmcblk3p3): lz4        : src c1207000 dst: c12066cb in: 4096b (4cac566d, bf629f60, 4) out: 6376b (dfcc8264)
[   12.656475] erofs: bf629f80 i_ino 868416, index 3 dst 82cfc000 (2b4319d2) err 0
[   12.664694] erofs: (device mmcblk3p3): lz4        : src c120a000 dst: c1208fb3 in: 4096b (74af795c, bf629f20, 6) out: 4651b (46c58dd7)
[   12.677549] erofs: bf629f60 i_ino 868416, index 4 dst 82cfb000 (7ce0249e) err 0
[   12.685754] erofs: bf629f40 i_ino 868416, index 5 dst 82cfa000 (d832cf73) err 0
[   12.694175] erofs: (device mmcblk3p3): lz4        : src c120d000 dst: c120c1de in: 4096b (d65a3a49, bf629f00, 7) out: 5360b (4364e0fc)
[   12.707097] erofs: bf629f20 i_ino 868416, index 6 dst 82cf9000 (aa9da9e7) err 0
[   12.715201] erofs: (device mmcblk3p3): lz4        : src c120f000 dst: c120e6ce in: 4096b (db73bb75, bf629ee0, 8) out: 4606b (c0a54f50)
[   12.728314] erofs: bf629f00 i_ino 868416, index 7 dst 82cf8000 (372b935) err 0
[   12.736367] erofs: (device mmcblk3p3): lz4        : src c1211000 dst: c12108cc in: 4096b (be653c3d, bf629ec0, 9) out: 4536b (10b3a4d0)
[   12.749215] erofs: bf629ee0 i_ino 868416, index 8 dst 82cf7000 (3ebcefe7) err 0
[   12.757651] erofs: (device mmcblk3p3): lz4        : src c1213000 dst: c1212a84 in: 4096b (8cd3cff3, bf629ea0, 10) out: 4285b (541c02fb)
[   12.770577] erofs: bf629ec0 i_ino 868416, index 9 dst 82cf6000 (12adb98e) err 0
[   12.779070] erofs: (device mmcblk3p3): lz4        : src c1215000 dst: c1214b41 in: 4096b (b885e4f7, bf629e80, 11) out: 4789b (af1820d3)
[   12.791988] erofs: bf629ea0 i_ino 868416, index 10 dst 82cf5000 (e8b33507) err 0
[   12.800438] erofs: (device mmcblk3p3): lz4        : src c1218000 dst: c1216df6 in: 4096b (3b4e9357, bf629e40, 13) out: 6216b (6a149c5)
[   12.813310] erofs: bf629e80 i_ino 868416, index 11 dst 82cf4000 (72cdfbb) err 0
[   12.821459] erofs: bf629e60 i_ino 868416, index 12 dst 82cf3000 (a4856fd6) err 0
[   12.830275] erofs: (device mmcblk3p3): lz4        : src c121c000 dst: c121a63e in: 4096b (a3bdbd0e, bf629e00, 15) out: 8015b (63d1fbc1)
[   12.843328] erofs: bf629e40 i_ino 868416, index 13 dst 82cf2000 (d027d81e) err 0
[   12.851321] erofs: bf629e20 i_ino 868416, index 14 dst 82cf1000 (307b732a) err 0
[   12.859966] erofs: (device mmcblk3p3): lz4        : src c121f000 dst: c121e58d in: 4096b (480285a7, bf629de0, 16) out: 6603b (822f8de0)
[   12.873015] erofs: bf629e00 i_ino 868416, index 15 dst 82cf0000 (39882425) err 0
[   12.881494] erofs: (device mmcblk3p3): lz4        : src c0995000 dst: c1220f58 in: 1839b (4f637f42, bf629dc0, 17) out: 5780b (55fe911f)
[   12.894479] erofs: bf629de0 i_ino 868416, index 16 dst 82cef000 (7f303847) err 0
[   12.902660] erofs: bf629dc0 i_ino 868416, index 17 dst 82cee000 (7e903556) err 0
[   12.910494] erofs: bf629da0 i_ino 868416, index 18 dst 82ced000 (e3449d72) err 0
[   12.920714] vfs_open: hash of /usr/lib/systemd/systemd: 0x0610c635
[   12.931295] vfs_open: /usr/lib/ld-linux-armhf.so.3
[   12.946124] erofs: (device mmcblk3p3): lz4        : src c1225000 dst: c1224000 in: 4096b (e4b39a2, bf629d40, 1) out: 4907b (aa05f0a3)
[   12.959147] erofs: bf629d60 i_ino 190291, index 0 dst 82ceb000 (20419a5e) err 0
[   12.967455] erofs: (device mmcblk3p3): lz4        : src c1227000 dst: c122632b in: 4096b (717fc925, bf629d20, 2) out: 4246b (c0f62dca)
[   12.980398] erofs: bf629d40 i_ino 190291, index 1 dst 82cea000 (64eb9a49) err 0
[   12.988432] erofs: (device mmcblk3p3): lz4        : src c1229000 dst: c12283c1 in: 4096b (8030d189, bf629d00, 3) out: 4292b (1df48c5f)
[   13.001322] erofs: bf629d20 i_ino 190291, index 2 dst 82ce9000 (7fc63af4) err 0
[   13.009526] erofs: (device mmcblk3p3): lz4        : src c122b000 dst: c122a485 in: 4096b (4aac6f77, bf629ce0, 4) out: 4289b (7dbbff69)
[   13.022469] erofs: bf629d00 i_ino 190291, index 3 dst 82ce8000 (285ac58c) err 0
[   13.030641] erofs: (device mmcblk3p3): lz4        : src c122d000 dst: c122c546 in: 4096b (e286b2b, bf629cc0, 5) out: 4207b (ec8e3f58)
[   13.043431] erofs: bf629ce0 i_ino 190291, index 4 dst 82ce7000 (63f2218c) err 0
[   13.051729] erofs: (device mmcblk3p3): lz4        : src c122f000 dst: c122e5b5 in: 4096b (e698fd35, bf629ca0, 6) out: 4291b (fcf580f8)
[   13.064654] erofs: bf629cc0 i_ino 190291, index 5 dst 82ce6000 (d2cc83a9) err 0
[   13.072712] erofs: (device mmcblk3p3): lz4        : src c1231000 dst: c1230678 in: 4096b (4859aa8f, bf629c80, 7) out: 4297b (ab8a8574)
[   13.085616] erofs: bf629ca0 i_ino 190291, index 6 dst 82ce5000 (fe13cf51) err 0
[   13.093964] erofs: (device mmcblk3p3): lz4        : src c1233000 dst: c1232741 in: 4096b (997436a4, bf629c60, 8) out: 4218b (be0817b8)
[   13.106809] erofs: bf629c80 i_ino 190291, index 7 dst 82ce4000 (a4994a5f) err 0
[   13.115151] erofs: (device mmcblk3p3): lz4        : src c1235000 dst: c12347bb in: 4096b (112a3fda, bf629c40, 9) out: 4271b (293ce253)
[   13.127996] erofs: bf629c60 i_ino 190291, index 8 dst 82ce3000 (9e8ba792) err 0
[   13.136087] erofs: (device mmcblk3p3): lz4        : src c1237000 dst: c123686a in: 4096b (fa3410b9, bf629c20, 10) out: 4673b (7f7a9871)
[   13.149454] erofs: bf629c40 i_ino 190291, index 9 dst 82ce2000 (902d97fe) err 0
[   13.157524] erofs: (device mmcblk3p3): lz4        : src c1239000 dst: c1238aab in: 4096b (634b03ca, bf629c00, 11) out: 4477b (cf289eb)
[   13.170471] erofs: bf629c20 i_ino 190291, index 10 dst 82ce1000 (60b7ab45) err 0
[   13.178797] erofs: (device mmcblk3p3): lz4        : src c123b000 dst: c123ac28 in: 4096b (326e1ba0, bf629be0, 12) out: 4254b (998b1f98)
[   13.191761] erofs: bf629c00 i_ino 190291, index 11 dst 82ce0000 (55814486) err 0
[   13.200025] erofs: (device mmcblk3p3): lz4        : src c123d000 dst: c123ccc6 in: 4096b (3c5b4505, bf629bc0, 13) out: 4175b (3bf4f1a9)
[   13.213001] erofs: bf629be0 i_ino 190291, index 12 dst 82cdf000 (717aa17d) err 0
[   13.221167] erofs: (device mmcblk3p3): lz4        : src c123f000 dst: c123ed15 in: 4096b (8e87c14d, bf629ba0, 14) out: 4288b (6a251e64)
[   13.234181] erofs: bf629bc0 i_ino 190291, index 13 dst 82cde000 (36a0d885) err 0
[   13.242519] erofs: (device mmcblk3p3): lz4        : src c1241000 dst: c1240dd5 in: 4096b (31a2e179, bf629b80, 15) out: 4257b (3e19e451)
[   13.255534] erofs: bf629ba0 i_ino 190291, index 14 dst 82cdd000 (8890a118) err 0
[   13.263944] erofs: (device mmcblk3p3): lz4        : src c0995000 dst: c1242e76 in: 4096b (65fa2fbe, bf629b60, 16) out: 4460b (ebe0126c)
[   13.276918] erofs: bf629b80 i_ino 190291, index 15 dst 82cdc000 (d48cbaf9) err 0
[   13.285456] erofs: (device mmcblk3p3): lz4        : src c1246000 dst: c1244fe2 in: 4096b (37a8bad1, bf629b20, 18) out: 4349b (c125197)
[   13.298312] erofs: bf629b60 i_ino 190291, index 16 dst 82cdb000 (940857ad) err 0
[   13.306341] erofs: bf629b40 i_ino 190291, index 17 dst 82cda000 (bd0e7a43) err 0
[   13.314760] erofs: (device mmcblk3p3): lz4        : src c1249000 dst: c12480df in: 4096b (8d172a42, bf629b00, 19) out: 4353b (1503ff28)
[   13.327777] erofs: bf629b20 i_ino 190291, index 18 dst 82cd9000 (dec8eb5c) err 0
[   13.336231] erofs: (device mmcblk3p3): lz4        : src c124b000 dst: c124a1e0 in: 4096b (1ef07e2b, bf629ae0, 20) out: 4869b (c3bf758b)
[   13.349213] erofs: bf629b00 i_ino 190291, index 19 dst 82cd8000 (6e7792a7) err 0
[   13.357541] erofs: (device mmcblk3p3): lz4        : src c124d000 dst: c124c4e5 in: 4096b (f4462dc1, bf629ac0, 21) out: 5484b (9b35c90f)
[   13.370740] erofs: bf629ae0 i_ino 190291, index 20 dst 82cd7000 (97b42709) err 0
[   13.379196] erofs: (device mmcblk3p3): lz4        : src c1250000 dst: c124ea51 in: 4096b (2ac6b4d5, bf629a80, 23) out: 5985b (94cc0d29)
[   13.392170] erofs: bf629ac0 i_ino 190291, index 21 dst 82cd6000 (29751a32) err 0
[   13.400416] erofs: bf629aa0 i_ino 190291, index 22 dst 82cd5000 (eeea8a30) err 0
[   13.409143] erofs: (device mmcblk3p3): lz4        : src c1253000 dst: c12521b2 in: 4096b (90757c3c, bf629a60, 24) out: 6356b (58df129b)
[   13.422165] erofs: bf629a80 i_ino 190291, index 23 dst 82cd4000 (a86b83ad) err 0
[   13.430562] erofs: (device mmcblk3p3): lz4        : src c1256000 dst: c1254a86 in: 4096b (971b791e, bf629a20, 26) out: 6045b (3a6bbefa)
[   13.443592] erofs: bf629a60 i_ino 190291, index 24 dst 82cd3000 (2535a069) err 0
[   13.451735] erofs: bf629a40 i_ino 190291, index 25 dst 82cd2000 (98287e49) err 0
[   13.460545] erofs: (device mmcblk3p3): lz4        : src c125a000 dst: c1258223 in: 4096b (9804bc65, bf6299e0, 28) out: 10510b (2a60a723)
[   13.473642] erofs: bf629a20 i_ino 190291, index 26 dst 82cd1000 (64b12fc2) err 0
[   13.481862] erofs: bf629a00 i_ino 190291, index 27 dst 82cd0000 (de4b4264) err 0
[   13.489996] erofs: (device mmcblk3p3): lz4        : src 85d73a35 dst: c125cb31 in: 1483b (5c99618c, bf68ae60, 0) out: 4759b (b53e5caa)
[   13.502976] erofs: bf6299e0 i_ino 190291, index 28 dst 82ccf000 (7881835d) err 0
[   13.511102] erofs: bf6299c0 i_ino 190291, index 29 dst 82cce000 (80d1e247) err 0
[   13.522922] vfs_open: hash of /usr/lib/ld-linux-armhf.so.3: 0xf1fe4854

> Thanks,
> Gao Xiang
> 
> 

Cheers,
Stefan

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |

