Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5F1292174
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 05:33:42 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CF2R73Xr0zDqZF
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 14:33:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603078419;
	bh=b606SwgwqpzDFurTLgfSyDt8vtgjaKWtLLgpNyxU/Fc=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mW3xkupX+n++QknpN1LI3Aayi7karyNw+nNuM6bKIHniaA73PIRt6gYWZmlLN9xN9
	 BbQ/2u1KPZlG/vXbOcSt+0RKMTqxeN0dAnli2Rko+K2EXs8y2rmPDQBdQIYi6GDVhp
	 nVmDClk4DPkI6d2Mj/OwqLCRe0xWR37n8pihpZo7Hjfqb5OJcXcLRhvj6FUMgAeiKm
	 aEMVWI44Vyl8lT1IGwB8KSMsmZVnZCd50Xl/Pi2ZRAZ0pfjJJRZX6qdApwD2alKCrn
	 pOu+g//VUH4xo0tJeAqlFnTswL8oPU3hcNTGeZHXES+bzexaWXCW9F5JzPjOoy4fdn
	 QPxTlYcP0xWDg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.84; helo=sonic305-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=dEKvBWaL; dkim-atps=neutral
Received: from sonic305-21.consmr.mail.gq1.yahoo.com
 (sonic305-21.consmr.mail.gq1.yahoo.com [98.137.64.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF2Qw0k36zDqLF
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Oct 2020 14:33:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603078396; bh=AYzhJEeE2mfZp+8zFlFkNMXEvNDdXP8HxN9pVmWBo9w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=dEKvBWaLY6PN0hoKVO753HeFO0r2/0NkBq02vyILNRiEoXYTRS3xIrqKGlrXXR3g9zGOaki6h7A/yHzXlcqqpeUD9eXSFgDJo6jiLq8Onx4E+2LABXZcfHCBhm1Ha6cPx5UxZtw66GpJt+rpMrL2EqZzBEYNEIipGKlvHp8eUEKlUbR7AI8pXF3+Lpgr+VuhnsmZMjS4TGOVc/FXgFjkiRMrnVw3fmjKY34rCgqWrZlY+a6WXIPwwLuI91cHWzrq5xnUGQGFOiogjK5lxN7JiOnO+RMPSrfxZVaDgeOKOx+k+T36LgNVXBqRmt+weervtSENG5AQ7JNLcWwBg2w5dg==
X-YMail-OSG: ezRGj4MVM1ku69xZBOspuKuemkbNIVAQCR7Fg1aZwiZdH8ZoHrJU3uBaRvWE8Nc
 L9f7BqxfJE0dkQvdY7lQnSa2AvQ7Czs0n_FOEIx.AbmVCX33zqJj0hRJ9pikgWua2RsJiO1sS7lE
 3A27YjuKHnXzDQ7Rpiqt0fJoSOW3uLoRRUDyAS8uMiDDO90Qd3OF6nA7ALn3pokKFHj77MI89pVE
 3BBSowMxsmLCbXNcSSL9nXIEKV7.D_CDSvhgA9ppuiJxVg23TeuaQ85Xk9qveMQDBnHWKSm_AAgj
 wCTkX.eTarIIIWbMFrb9.8I1jfdU9hl2iLAOqNNKrUYZutwE8nHaDksFiBTk0DsNBJDnLBS9dsSL
 MKo1hw8LxbWOxRXgmFF557lymqL2FOtqFOEtrKZlzi.vP.kaQ89e6WXA55Sj5bAv3kck_gXR9m0K
 A1OXwQZvoKMwpG.BJC7feTXMHVvsanFV5YDPUkv.RCN4.iS_S_LahKsXZISlzu4HCvWukyJep1h.
 r.n6LMDFkSgX73jLuUSW7.ZnIKvAhnN3Omg62rZUb_skJBPgyddl0Uw6Wnc7vfiPXmJ8MQhwDijE
 sgrTdYwC_F_j.9Zxfuv7D5wUqGey4gsTFbTIABxZPIuUsS.L.ORutQTSIYg6xMZM8qcm6iVxCoOs
 9TODJt7fmFrnhpwFvRnnmVx0gPqP48gTuJphHDA9ogsuJPbjfZoXHx8xQReUKmDkzINyHIdpnnqY
 3TQU7PKin94VvxXCpjydnDAXqfTAbRtB7k1W.1TW_VU3dDJPRpeRD.WjSkMdITGpabn9ja_VGlpO
 cVdXslOOCjPNidOUijZrV9K1.wuo89xnhsh.mIIhkxewwSJwOM6vnh7ivUM0q0Ws6SfyqmFuR8sv
 F8rTlCKQqtnMzSP18Pwuo2O6K5KPxNUKdAqWNjfUwCDw6QYykA4WVrn9Lppt_hW9uIuTgOIn0g0h
 TVW3sGH9EpLinz1TdpxnQq82F2pvekPFCVeiSRsZnH7Zf0JafemPALWbXlMaFQ5Iqf1jKYh6gnVs
 58nhfEVLK5tQKI21yTn3BSi.k6bVbmrEWALi3RLFJNMhr4rXueE66VRT8JasqiWJHtDtKjGtiAzJ
 DBeD0AsMrC.gI76nNFvaXHCUTpgyV_9A_9MFWRe82NAxzW3C_a.zP7Ut1EnKIzGljwOFQC9JqOMM
 CjI2T1K0tj_MXXSexNWMpSS6Z2cR_hBwcB7DUGfKJZaw5iZtIB3EC3aeQE.ttyzTCa7.xQK9hEJI
 QT.TT0kuRAgREi3lAAp1BPnM9lBCyEsfsmtxUdjr.ZyMeMLNY0jyrUMgq4gejcF_cB2LC0HiDXjd
 2xd.KTLVrldFk4k.yz.nt.9fkIx.45hiSdZ5AbzIeY2ZfFv2UKgsDsgrI1efiAKuPyAvUpsKrJvC
 71idtm1CNOiKG1ThlVo1sAcxrKYOmohEOYDj_rNgVpXZZv0qIRhdYWCHL7Eg8c.QwD5L2Y6XP0V1
 ZyNT575LJymOUI46Jz3r8iD62TolMHi9yyiZUWEyGKyeBQVChrKDFfwSLVvBF5KfahyhQcog-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 19 Oct 2020 03:33:16 +0000
Received: by smtp418.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 5327caa9eb7579a37746b1ed53a7a010; 
 Mon, 19 Oct 2020 03:33:11 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:32:59 +0800
To: "huangjianan@oppo.com" <huangjianan@oppo.com>
Subject: Re: =?gbk?B?u9i4tDogW1dJUF0gW1BBVEM=?= =?gbk?Q?H?= 04/12]
 erofs-utils: fuse: adjust larger extent handling
Message-ID: <20201019033251.GA29138@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201017051621.7810-1-hsiangkao@aol.com>
 <20201017051621.7810-5-hsiangkao@aol.com>
 <2020101911134102451012@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2020101911134102451012@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16868
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
Cc: guoweichao <guoweichao@oppo.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>,
 zhangshiming <zhangshiming@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Mon, Oct 19, 2020 at 11:13:42AM +0800, huangjianan@oppo.com wrote:
> Hi, Gao Xiang��
> ________________________________
> 
> �����ˣ� Gao Xiang<mailto:hsiangkao@aol.com>
> ����ʱ�䣺 2020-10-17 13:16
> �ռ��ˣ� linux-erofs<mailto:linux-erofs@lists.ozlabs.org>
> ���ͣ� Huang Jianan<mailto:huangjianan@oppo.com>; Li Guifu<mailto:bluce.liguifu@huawei.com>; Li Guifu<mailto:bluce.lee@aliyun.com>; Chao Yu<mailto:chao@kernel.org>; Guo Weichao<mailto:guoweichao@oppo.com>; Zhang Shiming<mailto:zhangshiming@oppo.com>; Gao Xiang<mailto:hsiangkao@aol.com>
> ���⣺ [WIP] [PATCH 04/12] erofs-utils: fuse: adjust larger extent handling
> so more easy to understand.
> 
> [ let's fold in to the original patch. ]
> Cc: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> fuse/read.c | 13 +++++++++----
> 1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fuse/read.c b/fuse/read.c
> index 0d0e3b0fa468..dd44adaa1c40 100644
> --- a/fuse/read.c
> +++ b/fuse/read.c
> @@ -112,12 +112,17 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
> Z_EROFS_COMPRESSION_LZ4 :
> Z_EROFS_COMPRESSION_SHIFTED;
> - if (end >= map.m_la + map.m_llen) {
> - count = map.m_llen;
> - partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
> - } else {
> + /*
> + * trim to the needed size if the returned extent is quite
> + * larger than requested, and set up partial flag as well.
> + */
> + if (end < map.m_la + map.m_llen) {
> count = end - map.m_la;
> partial = true;
> + } else {
> + ASSERT(end == map.m_la + map_m_llen);
> 
> I think you mean map.m_llen intesad of map_m_llen.
> Besides, I don't understand why add ASSERT here.
> I think this condition will be true if offset+size is exactly the end of a compressed block?

Thanks for your question.
The idea is that we requested the extent with

	map.m_la = end - 1;

	ret = z_erofs_map_blocks_iter(vnode, &map);
	if (ret)
		return ret;

so the extent must include "end - 1", so
it's impossible that "end > map.m_la + map.m_llen"
(invalid return).

or the entire extent would be holed extent, anyway,
that is another extent rather than a data extent.

(BTW, the up-to-date commits is at
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=wip/experimental_fuse
kindly check out them as well :) )

Thanks,
Gao Xiang


> 
> + count = map.m_llen;
> + partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
> }
> if ((off_t)map.m_la < offset) {
> --
> 2.24.0
> 
> Thanks,
> Jianan

