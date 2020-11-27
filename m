Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894822C640F
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 12:47:17 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjCXf3TcpzDrdh
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 22:47:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1606477634;
	bh=jH+5xmbqIAtpAN1PJtK4QM1SjE5P4Nm5e3VWrhwbR5Q=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=QuUr9L2Hts0SeXklbYZDPy9qAGdahzI4Xef818MAUn/ox4g5IktqFN8hPLpnEPNYM
	 pbQCxOzWVq+WpVH2SvfZ5hQ2QK8GDQgRjvbkbI7hVQMcsDpCl8P4GdNRHRJEzN+qzb
	 N6HzTi9P+WDn2Atd5nUIVO4n3e0UuuuKQ6Q9HZDFarbAxEJnv3h8FhE4xwEdnQlItr
	 rZDzKwNz6BvhnlJYjduojFfHt75r/NDPHi5yesoTPSIF59BHVoSRLJPwAKzkZYD62M
	 ljuBMDjQoYCgiKesXVtbxCij0Hw3OB4bPPbI8hkwo9roSc6bNDiUKjMih34iVDBjKN
	 cM3tWDDKi6dYw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.204; helo=sonic312-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=ftaYJ4f7; dkim-atps=neutral
Received: from sonic312-23.consmr.mail.gq1.yahoo.com
 (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjCX345qtzDrc1
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 22:46:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1606477596; bh=b9EsWkOIzGFBGDX7QWkiJvPAabGPp+tqnXQoBXqQFGU=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=ftaYJ4f7fToz7JgwAgSpCZWCsBUwa8lKUrebrJ4JMNjkSeUScnOP6PTbxda/CKHu/yt5cOQoawejDjD3RRnyj6whNC1z+aDnaHzFU+H5SpqUsEhTU2C0YOy6/6qmF0Dh+Y/WvjZYhkKFR9lGUv8emiAiGHD+2Vec4Hb3N++n94bUamiHbntEIj3B5wWw3JLxT2i2Q80ciMO6H74AD8/NtHRwi5IETfwwFUWbQrfi24K7cc1fCP3e5bH9enlxf/lfv1mLkSksMK+oBz8CukdsvZqDc+QsTrNKtb5Hqbiu2T2N4vsh9SJdKyLK0Nwo0KYVTGRxiT7pchVtTNzN6BFo0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1606477596; bh=LXowVmmGmK9cvlvep6pc3J5Wh3zzeSEDgQTmikspfIP=;
 h=From:To:Subject:Date:From:Subject;
 b=IFyQXwZYX0apFT3eWr5+ztEJPSuYm18D9MCAxkBliOoaq6vYxANPfCrsY4HHhmk1EF29g/RYBB6BwyH9fxRsemYz/rlW3C6DnMCE+GU7kn0o9INXtyspmU8t9ZNHcwUZy8Z5i+Epwofd8Zv+B5m11YhRLYalTG0tAMLS4SqNV2LBYQMDXcXX2g55B+dKtSj1CjktOUgrkktxd11J9EPPd+8FE4Ox0lYwZozku/CAsVzCpP2MtSat4VU85eIwNPsOSukxMsV5TrqjC9pck0EnGBjHDsEf67LbxjYF27PkmtRVlVotoyh2EHaKOLEqEUCj20D6fFiEy/ZYU2iC9sPxJQ==
X-YMail-OSG: lBlcbEAVM1nKgW3iRm_hWuVHEF4NTLAJMEZvJ4te2qBFapfiTAdQnnALyGnP6EO
 sIcjihNtokhlehx3BkgaqMzvy9mXEf7L9qoiAxwU7hvP1Cibmn1pKs9YCZmMwAMfFJQfHM7gettt
 mLGC6UhLqolePY2ydLbDlDE0k4oTh4l3meL.2F.Afwh4XQ2vyL9tSMY9qFngvx75bj4s06Ev.Ma.
 2dlA.onM8295HLNW628cGuGXtH81puqWPoWD9bwKZpRcZfn70mPzCUqgroplZeI38IDqp95oSavv
 jDNP2ID3kyxt6eu4h1qh3cyQsmJfHO4mFPLkcRihp4RCprUUn0tti_lTmOxRFvf60zA3mFR6Ql2S
 0UCnxvOb6zsEeuTl83R.HLc1JlcyJg0bQ9F6xYUktjhLKWPglIi.J91x_WxjkBKqPTeiU5Rbk1vq
 QDwecYEbX4b1xey8Of5HHBRqlK8Y7kvQ.1D7aHzvYc840WM3qJeBhmFc1LrXpdzk0ZLyQwrMRKVj
 L5iN1suME2TxpUTu8M4eNCmK3mURX9DFQP9H6p9UMppv4UkJcggVoe6Xk0K40VlJ1l9z7j2cAnLe
 2P_8OXSodedDJwQnGOysSdfOnGStH1QmynRr1tSQNH57NRbuAfVtFk5yrN3_TqNv16N8OcXHTuZC
 53JpLrNldQjbFMaYoJnPrTGWfgsGKdzN9kijIIQmIXv5UANleBl8.10ygxyG9wE2yp32LYQNMXTu
 wqNZFU88IQEfmxPnw7N_mjMb.XrjzAHGSDFRtpOLXX4LBcTrrXNiVie7ZivbKjesTclk.NSTQRjk
 3Rj1kr5jwW8tEjAtwbODs1yeqSwpu7YLFc2SDK12_Q2DhL27wOB9pOXWemlcXJ5xNGcZ_lelJ1Ch
 n4ghYrsdjA_otGinpNWTTfKlmAfZYkEBwjxSq6OG37xpuE3KNd6L5MK5_9B1KliVQ4YjO8sDKlTK
 0md25rQPGvj9ImIl6khdtAmvf54yTkP8MWkTdvof1XzRvSjbP.t2f1ELtKxvk6tkDUDDuay7VJLK
 ._leurovyjrv6ni09VlAXDPYhs.X1FLzsP9etGGZAeTtsQKyxAS1_jUB6YPgSdH934E09B9zAmVN
 U3ARnPNSIC9egjhCwazGy7moj.iFqlkw7W5gqc.KhODn2hxga6leBQhgMdFs4QIjt5L5Wi7IFu4L
 oMZDvqYNhPkyxant4A0Faax.gmlgf1ZTFnhNTHa1s_K398EDbWjIbuwYtbMFSZpQPoYBrh_rT2bz
 Gli7BujDn23xfLdW21A43bDG2_AVSeMVZGkVk8lexOFvv_4y08JqgsGRrlxWDz0DjgpT2FJeEojz
 g4HawWHQjvXc3NpYelVX5BUFhugx4a0lBDOcC2Oz3_XKSogK7SZU723pkJuedT4A4CTBXz7XMy8Y
 YMPd95wr8JjBaqhqG8_OsTgq7_yKyq1uRySHFy54fzQTRAvntcyD.m.y54eiN1v21Y1DleVaWJ3V
 Puqj8iHetgLvlsFl0v94Qbfdfz70GDR.yKem2G0tUhTmlv3MqYFw7mQczn59ZFjlQLfg888U3ET9
 vfc2lGjO1w.aEedFwuPgycwJPqVxORVu_ndSuotzLUOwef198lspwaSZM6vHlBnKGFC7QmXnD1TZ
 ivQTIDOPHZP4VSgqETkYT7p3hmZVOAh.PEgrkbWkB.b7ltQ2OMINWEUNFvpyNgYViOxa11cDW3X6
 _MJkQ8skUwAAFgYp7YSc2uLmgDM1P_hyTKkroPaifRNaS02.7s_1d8oHAiqpUJKzKaniZ_0PHuhu
 YMrv7v5Q8mwTEcEfsil5PSBxRYmKai_qTuJ7UxK1L0CGh1JO8Wj.TTL_RfFofjTD4O1VhnQWqm2z
 fm4bZRN_G65CbB5xMsrxGbjSwpLFLUjTV_7l3xq4CSXPL6M44G0ziYoRIFceR.gf1ySweyD_T3rz
 RDrfgX3b_MXvy8XQN.043kizhRHFYkKjvHAC6lSE6pXhnvpYdDQtIZoVsounKoAcLbQXdUW6zfds
 vcfVae_E2N3rf94ETnsZ_ugVbPiBkF83Dljw_ad2Y7uFXL0g2vqzfxcUo0grj8SPqzgOn348Aajr
 wntNn9HlyKhGt0OxgTZ3OHnH_Qoju6Lq8VahC7FeWoBaPy2xJCnOMuutLIB.76_R5uLWIiEs.lzO
 VRb0JhU8IPEjl3PNeE1uoFsZkUz7LN8N_FNRtl8PCYPErCUHTvpqONuXDciJkb1hx1Q7twKn1UWo
 Kr8sDBQsaH9TQ3JwxrsUbYfZ.WVZJGjbPIS2RHUchozG0vujkaMzSTxol0N5RDoazl2trteEaYtH
 8FYGAQW3oqc1xc9SGxmX8m27c9.Ngas74irSe7ENDBnQMMGkogLn1wsegsMwDupQJvqeZ6P1v0QZ
 GZPyAhUaB0NGIuUSt6kAz20ynWKfqml2RjIfmSHg77bjV0vuqHBUum_RlqZllmqOqCPrP5ixyth4
 on_Z.ebL6EpW30YIW4arzaiU9JeUehPnoEvih1wQL8FPDt8bW7UsUsS6lgEXlgkXUvli4zN7PMCb
 OMhXoR3U4dl6Dh7ZZIyg0dVnqWPXJWzILFxrFisWqv1CrsyjXRK6P7Hcs.EhZDQxjimsfvIDGPDd
 .6N6UxmmyJOj2nt6oKsjPVsyG_G.Ryw3bRBrchy3uKqc3eGmLwMmHEB9zN9TLHivnUr4P.99bW2g
 jAERN3Lgoa7oz9bleTpzWMqJKLbsakNdzz3OP43GhYw1Ssn9f08a0wPArTiO1M9NI0ouowL5FKTj
 uiaD.8mgc73Q9DZnpzvgWruE364Q2GQFCMks3ey0Hguzw6BWwHHtrlSbt2tnrd.mDYJ1dmk90VvV
 IicpEYPNg26zfZnD022XkzFm7Oz2qbZQWCogThfciOx4bdhqK
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Fri, 27 Nov 2020 11:46:36 +0000
Received: by smtp425.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 3a2b2602d95632a301ae818aa8f56dbe; 
 Fri, 27 Nov 2020 11:46:34 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 0/3] erofs-utils: introduce fuse implementation
Date: Fri, 27 Nov 2020 19:46:14 +0800
Message-Id: <20201127114617.13055-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201127114617.13055-1-hsiangkao.ref@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

changes since v2:
 - erofs_dbg() -> erofs_dump() in signal_handle_sigsegv() (Guifu);
 - get rid of unnecessary new lines (Guifu).

changes since v1:
 - fix off-by-one error of namebuf in erofs_fill_dentries();
 - drop unused "struct erofs_super_block super;" in lib/super.c; 
 - fix clang/32-bit build errors founded by travis CI.

Hi all,

I've finished cleaning up erofsfuse - a fuse implementation of erofs
just now. It's now considered as multithread safe since it's
currently stateless by killing useless caches and using high-level
libfuse APIs(also libfuse itself is MT-safe). Therefore, I don't
need to release another liberofs MT-safe version for now as well.

As I said eariler, the main usage of erofsfuse is to support handling
erofs images on older kernels without kernel modification, which
was requested by real vendors (thanks to folks from OPPO to pick
it up).

And to summarize the benefits of erofsfuse, I think it would be:

 - erofs images can be supported on various platforms;
 - an independent unpack tool can be developed based on this;
 - new on-disk feature can be iterated, verified effectively.

erofsfuse will be included in the upcoming erofs-utils v1.2, but
disabled by default for now. Since it still needs sometime to
stablize and also notice LZ4_decompress_safe_partial() was broken
in lz4-1.9.2, which just fixed in lz4-1.9.3 days ago [1].

BTW, recently some other people get in touch with me in private
to ask for some latest micro-benchmark among compression fses,
so I spared some extra time on this as well, see:
https://github.com/erofs/erofs-openbenchmark/wiki/linux_5.10_rc4-compression-FSes-benchmark
I might test on hikey960 board as well yet need to seek more
extra time but I think no much difference on relative
relationship (but yeah, CPU-storage combination is vital for
seqread uplimit).

Thanks,
Gao Xiang

Cc: Li Guifu <blucerlee@gmail.com>
Cc: Huang Jianan <huangjianan@oppo.com>
Cc: Guo Weichao <guoweichao@oppo.com>

Huang Jianan (2):
  erofs-utils: fuse: support symlink & special inode
  erofs-utils: fuse: add compressed file support

Li Guifu (1):
  erofs-utils: introduce fuse implementation

 Makefile.am                |   4 +
 configure.ac               |  22 +-
 fuse/Makefile.am           |  10 +
 fuse/dir.c                 | 103 +++++++++
 fuse/main.c                | 240 +++++++++++++++++++++
 include/erofs/decompress.h |  35 ++++
 include/erofs/defs.h       |   5 +
 include/erofs/internal.h   |  92 +++++++-
 include/erofs/io.h         |   1 +
 include/erofs/trace.h      |  14 ++
 include/erofs_fs.h         |   4 +
 lib/Makefile.am            |   4 +-
 lib/data.c                 | 204 ++++++++++++++++++
 lib/decompress.c           |  87 ++++++++
 lib/io.c                   |  16 ++
 lib/namei.c                | 264 +++++++++++++++++++++++
 lib/super.c                |  78 +++++++
 lib/zmap.c                 | 415 +++++++++++++++++++++++++++++++++++++
 18 files changed, 1594 insertions(+), 4 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/dir.c
 create mode 100644 fuse/main.c
 create mode 100644 include/erofs/decompress.h
 create mode 100644 include/erofs/trace.h
 create mode 100644 lib/data.c
 create mode 100644 lib/decompress.c
 create mode 100644 lib/namei.c
 create mode 100644 lib/super.c
 create mode 100644 lib/zmap.c

-- 
2.24.0

