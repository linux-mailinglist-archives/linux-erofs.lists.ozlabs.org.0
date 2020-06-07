Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC841F0C5C
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Jun 2020 17:10:46 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49g0FH2M9YzDqZ3
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Jun 2020 01:10:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=163.com
 (client-ip=123.126.97.2; helo=mail-m972.mail.163.com;
 envelope-from=wylgf01@163.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=ich9R27c; dkim-atps=neutral
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49g0F25WYnzDqVJ
 for <linux-erofs@lists.ozlabs.org>; Mon,  8 Jun 2020 01:10:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=/MCZ0
 LLnBYJB4YBYohPq5J1RwN5rkHoghrx3e6pdb0o=; b=ich9R27cg23F+WUvg70Ph
 ATBa5oXn/0lkPtveEn0DS8RN2q9thnFt6rcTwwqdSTBvqVvFM60zEcMn2kQraak7
 oefO3rd+EQ1a77SwOf0La+4wbC6fHp2Ck3ofbkoCZHbokdb4AUwBj21e33y5zjK3
 qUZWjLMLfQblMHT+Bas1S8=
Received: from [192.168.3.5] (unknown [223.167.142.197])
 by smtp2 (Coremail) with SMTP id GtxpCgD3mL21_9xe66IvDg--.22036S2;
 Sun, 07 Jun 2020 22:54:45 +0800 (CST)
Subject: Re: [PATCH] erofs-utils: enhance static linking for lz4 1.8.x
To: linux-erofs@lists.ozlabs.org
References: <20200531034510.5019-1-hsiangkao.ref@aol.com>
 <20200531034510.5019-1-hsiangkao@aol.com>
From: Li Guifu <wylgf01@163.com>
Message-ID: <fe87a52a-1ef1-5125-b3d0-e3e56dc54cc5@163.com>
Date: Sun, 7 Jun 2020 22:54:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200531034510.5019-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GtxpCgD3mL21_9xe66IvDg--.22036S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW5Jw4kGF48WryDJF43Wrg_yoWxKrc_ur
 4vyFs7ur4DAFsakr48AwsI9r43ua18WrZxG3WUZr4rA390q3Z7Zrs5XrnFq3W7Za1kCrZx
 XF4SvFWrKFy2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0aZX5UUUUU==
X-Originating-IP: [223.167.142.197]
X-CM-SenderInfo: pz1owwiqr6il2tof0z/xtbBERc8y1aD-KOZjAABsv
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2020/5/31 11:45, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
>
> Since LZ4_compress_HC_destSize is static linking only on lz4 < 1.9.0,
> but usually both lz4 static and dynamic library are available.
>
> Previously, -all-static is used in erofs-utils compilation for such
> lz4 versions, but it has conficts with libselinux linking. Use another
> workable way [1] I've found instead.
>
> [1] https://stackoverflow.com/questions/8045707/how-to-link-to-the-libabc-a-instead-of-libabc-so
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> It looks good
> Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
> Tested-by: Li Guifu <bluce.lee@aliyun.com>

